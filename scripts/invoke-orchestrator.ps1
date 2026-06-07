param(
    [Parameter(Mandatory = $true)]
    [string]$Workflow,

    [string]$TaskId = '',
    [string]$Goal = '',
    [ValidateSet('low', 'medium', 'high')]
    [string]$RiskHint = '',
    [string]$RequestedAction = '',
    [string]$OutputPath = ''
)

$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
. (Join-Path $PSScriptRoot 'agent-yaml-utils.ps1')

$workflowPath = Resolve-Path -LiteralPath $Workflow
$content = Get-Content -LiteralPath $workflowPath.Path -Raw -Encoding UTF8

$workflowId = Get-YamlScalar -Content $content -Key 'workflow_id'
$workflowName = Get-YamlScalar -Content $content -Key 'name'
$riskDefault = Get-YamlScalar -Content $content -Key 'risk_default'
$primaryAgent = Get-YamlNestedScalar -Content $content -Section 'agents' -Key 'primary'
$reviewAgents = Get-YamlNestedArray -Content $content -Section 'agents' -Key 'reviewers'
$archiveAgent = Get-YamlNestedScalar -Content $content -Section 'agents' -Key 'archive'
$contextPaths = Get-YamlTopLevelArray -Content $content -Key 'context_paths'
$outputPaths = Get-YamlTopLevelArray -Content $content -Key 'output_paths'
$forbiddenActions = Get-YamlNestedArray -Content $content -Section 'guardrails' -Key 'forbidden_actions'
$highRiskPolicy = Get-YamlNestedScalar -Content $content -Section 'guardrails' -Key 'high_risk_policy'

if ([string]::IsNullOrWhiteSpace($TaskId)) {
    $TaskId = 'TASK-' + (Get-Date -Format 'yyyyMMdd-HHmmss')
}

$riskLevel = $riskDefault
if (-not [string]::IsNullOrWhiteSpace($RiskHint)) {
    $riskLevel = $RiskHint
}

$requestedActionIsForbidden = $false
if (-not [string]::IsNullOrWhiteSpace($RequestedAction)) {
    $requestedActionIsForbidden = $forbiddenActions -contains $RequestedAction
}

$approvalRequired = ($riskLevel -eq 'high') -or $requestedActionIsForbidden
$approvalState = if ($approvalRequired) { 'pending_founder_approval' } elseif ($riskLevel -eq 'medium') { 'reviewed' } else { 'draft' }

$auditLogDraft = [ordered]@{
    task_id = $TaskId
    workflow_id = $workflowId
    workflow_name = $workflowName
    goal = $Goal
    requested_action = $RequestedAction
    assigned_primary_agent = $primaryAgent
    assigned_review_agents = @($reviewAgents)
    archive_agent = $archiveAgent
    risk_level = $riskLevel
    approval_required = $approvalRequired
    approval_state = $approvalState
    context_paths = @($contextPaths)
    output_paths = @($outputPaths)
    audit_log_required = $true
    evidence_paths = @($contextPaths)
    created_at = (Get-Date).ToString('o')
}

$result = [ordered]@{
    task_id = $TaskId
    workflow_id = $workflowId
    workflow_name = $workflowName
    primary_agent = $primaryAgent
    review_agents = @($reviewAgents)
    archive_agent = $archiveAgent
    risk_level = $riskLevel
    approval_required = $approvalRequired
    approval_state = $approvalState
    high_risk_policy = $highRiskPolicy
    allowed_output_paths = @($outputPaths)
    audit_log_draft = $auditLogDraft
}

if ($approvalRequired) {
    $result['founder_approval_package'] = [ordered]@{
        approval_id = 'APP-' + $TaskId
        requested_by = $primaryAgent
        reviewed_by = @($reviewAgents)
        risk_level = 'high'
        requested_action = if ([string]::IsNullOrWhiteSpace($RequestedAction)) { 'workflow_high_risk_path' } else { $RequestedAction }
        evidence_paths = @($contextPaths)
        founder_decision = 'pending_founder_approval'
        rollback_plan = 'pending_verification'
    }
}

$json = $result | ConvertTo-Json -Depth 10

if (-not [string]::IsNullOrWhiteSpace($OutputPath)) {
    $parent = Split-Path -Parent $OutputPath
    if (-not [string]::IsNullOrWhiteSpace($parent)) {
        New-Item -ItemType Directory -Force -Path $parent | Out-Null
    }
    Set-Content -LiteralPath $OutputPath -Value $json -Encoding UTF8
}

Write-Output $json
