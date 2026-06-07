$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
. (Join-Path $PSScriptRoot 'agent-yaml-utils.ps1')

$failures = New-Object System.Collections.Generic.List[string]

function Add-Failure {
    param([string]$Message)
    [void]$failures.Add($Message)
}

function Require-TopLevelKey {
    param([string]$Content, [string]$Key, [string]$File)
    if ([string]::IsNullOrWhiteSpace((Get-YamlScalar -Content $Content -Key $Key))) {
        Add-Failure "$File missing top-level key: $Key"
    }
}

function Require-ExistingPathList {
    param([string[]]$Paths, [string]$File, [string]$Key)
    if ($Paths.Count -eq 0) {
        Add-Failure "$File has empty path list: $Key"
        return
    }
    foreach ($path in $Paths) {
        $full = Join-Path $root $path
        if (-not (Test-Path -LiteralPath $full)) {
            Add-Failure "$File references missing path in ${Key}: $path"
        }
    }
}

$schemaFiles = @(
    'schemas/workflow.schema.json',
    'schemas/eval.schema.json',
    'schemas/handoff-package.schema.json',
    'schemas/approval-package.schema.json'
)

foreach ($schemaFile in $schemaFiles) {
    $full = Join-Path $root $schemaFile
    if (-not (Test-Path -LiteralPath $full)) {
        Add-Failure "Missing schema file: $schemaFile"
        continue
    }
    try {
        $schema = Get-Content -LiteralPath $full -Raw -Encoding UTF8 | ConvertFrom-Json
        if ($null -eq $schema.required -or $schema.required.Count -eq 0) {
            Add-Failure "$schemaFile has no required field list"
        }
    } catch {
        Add-Failure "$schemaFile is not valid JSON"
    }
}

$workflowRequired = @('workflow_id', 'name', 'description', 'risk_default', 'trigger', 'agents', 'context_paths', 'output_paths', 'steps', 'guardrails')
$forbiddenRequired = @('payment', 'contract_signing', 'external_send', 'privacy_policy_change', 'security_exception', 'mass_production_commitment')
$workflowFiles = Get-ChildItem -LiteralPath (Join-Path $root 'workflows') -Filter '*.yaml' -File

foreach ($workflowFile in $workflowFiles) {
    $relative = ConvertTo-RepoRelativePath -Path $workflowFile.FullName -Root $root
    $content = Get-Content -LiteralPath $workflowFile.FullName -Raw -Encoding UTF8
    foreach ($key in $workflowRequired) {
        if ($content -notmatch "(?m)^$([regex]::Escape($key))\s*:") {
            Add-Failure "$relative missing required key: $key"
        }
    }

    $risk = Get-YamlScalar -Content $content -Key 'risk_default'
    if (@('low', 'medium', 'high') -notcontains $risk) {
        Add-Failure "$relative has invalid risk_default: $risk"
    }

    $primary = Get-YamlNestedScalar -Content $content -Section 'agents' -Key 'primary'
    if ([string]::IsNullOrWhiteSpace($primary)) {
        Add-Failure "$relative missing agents.primary"
    }

    $reviewers = Get-YamlNestedArray -Content $content -Section 'agents' -Key 'reviewers'
    if (($risk -eq 'medium' -or $risk -eq 'high') -and $reviewers.Count -eq 0) {
        Add-Failure "$relative medium/high workflow requires reviewers"
    }

    $archive = Get-YamlNestedScalar -Content $content -Section 'agents' -Key 'archive'
    if ([string]::IsNullOrWhiteSpace($archive)) {
        Add-Failure "$relative missing agents.archive"
    }

    Require-ExistingPathList -Paths (Get-YamlTopLevelArray -Content $content -Key 'context_paths') -File $relative -Key 'context_paths'
    Require-ExistingPathList -Paths (Get-YamlTopLevelArray -Content $content -Key 'output_paths') -File $relative -Key 'output_paths'

    $forbidden = Get-YamlNestedArray -Content $content -Section 'guardrails' -Key 'forbidden_actions'
    foreach ($requiredAction in $forbiddenRequired) {
        if ($forbidden -notcontains $requiredAction) {
            Add-Failure "$relative guardrails missing forbidden action: $requiredAction"
        }
    }

    $highRiskPolicy = Get-YamlNestedScalar -Content $content -Section 'guardrails' -Key 'high_risk_policy'
    if ($highRiskPolicy -ne 'founder_approval_required') {
        Add-Failure "$relative high_risk_policy must be founder_approval_required"
    }
}

$evalRequired = @('eval_suite_id', 'name', 'description', 'version', 'gates', 'cases')
$requiredGates = @('routing_gate', 'evidence_gate', 'risk_gate', 'approval_gate', 'output_gate', 'placeholder_gate')
$evalFiles = Get-ChildItem -LiteralPath (Join-Path $root 'evals') -Filter '*.yaml' -File

foreach ($evalFile in $evalFiles) {
    $relative = ConvertTo-RepoRelativePath -Path $evalFile.FullName -Root $root
    $content = Get-Content -LiteralPath $evalFile.FullName -Raw -Encoding UTF8
    foreach ($key in $evalRequired) {
        if ($content -notmatch "(?m)^$([regex]::Escape($key))\s*:") {
            Add-Failure "$relative missing required key: $key"
        }
    }
    foreach ($gate in $requiredGates) {
        if ($content -notmatch "(?m)^\s{2}$([regex]::Escape($gate))\s*:") {
            Add-Failure "$relative missing gate: $gate"
        }
    }

    $cases = Get-YamlListItemBlocks -Content $content -Section 'cases'
    if ($cases.Count -eq 0) {
        Add-Failure "$relative has no eval cases"
    }
    foreach ($case in $cases) {
        $caseId = Get-YamlBlockScalar -Block $case -Key 'case_id'
        if ([string]::IsNullOrWhiteSpace($caseId)) {
            Add-Failure "$relative has case without case_id"
            continue
        }
        foreach ($key in @('workflow_id', 'expected_primary_agent', 'expected_risk_level')) {
            if ([string]::IsNullOrWhiteSpace((Get-YamlBlockScalar -Block $case -Key $key))) {
                Add-Failure "$relative case $caseId missing $key"
            }
        }
        if ((Get-YamlBlockArray -Block $case -Key 'required_gates').Count -eq 0) {
            Add-Failure "$relative case $caseId has no required_gates"
        }
    }
}

$handoffExample = Join-Path $root 'docs/audit/examples/handoff-package-example.yaml'
$approvalExample = Join-Path $root 'docs/audit/examples/approval-package-example.yaml'
foreach ($example in @($handoffExample, $approvalExample)) {
    if (-not (Test-Path -LiteralPath $example)) {
        Add-Failure "Missing package example: $(Split-Path -Leaf $example)"
    }
}

if (Test-Path -LiteralPath $handoffExample) {
    $content = Get-Content -LiteralPath $handoffExample -Raw -Encoding UTF8
    foreach ($key in @('task_id', 'workflow_id', 'from_agent', 'to_agent', 'risk_level', 'approval_state', 'context_paths', 'output_paths')) {
        if ($content -notmatch "(?m)^$([regex]::Escape($key))\s*:") {
            Add-Failure "handoff package example missing $key"
        }
    }
}

if (Test-Path -LiteralPath $approvalExample) {
    $content = Get-Content -LiteralPath $approvalExample -Raw -Encoding UTF8
    foreach ($key in @('approval_package', 'task_id', 'requested_by', 'reviewed_by', 'risk_level', 'founder_decision')) {
        if ($content -notmatch "(?m)^\s*$([regex]::Escape($key))\s*:") {
            Add-Failure "approval package example missing $key"
        }
    }
}

if ($failures.Count -gt 0) {
    Write-Host "Schema validation failed:" -ForegroundColor Red
    foreach ($failure in $failures) {
        Write-Host "- $failure" -ForegroundColor Red
    }
    exit 1
}

Write-Host "Schema validation passed."
