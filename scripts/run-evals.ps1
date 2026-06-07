$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
. (Join-Path $PSScriptRoot 'agent-yaml-utils.ps1')

$schemaCheck = & powershell -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot 'validate-schemas.ps1') 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host $schemaCheck
    exit $LASTEXITCODE
}

$failures = New-Object System.Collections.Generic.List[string]
$caseCount = 0

function Add-Failure {
    param([string]$Message)
    [void]$failures.Add($Message)
}

$evalFiles = Get-ChildItem -LiteralPath (Join-Path $root 'evals') -Filter '*.yaml' -File

foreach ($evalFile in $evalFiles) {
    $evalContent = Get-Content -LiteralPath $evalFile.FullName -Raw -Encoding UTF8
    $cases = Get-YamlListItemBlocks -Content $evalContent -Section 'cases'

    foreach ($case in $cases) {
        $caseCount += 1
        $caseId = Get-YamlBlockScalar -Block $case -Key 'case_id'
        $workflowId = Get-YamlBlockScalar -Block $case -Key 'workflow_id'
        $expectedPrimary = Get-YamlBlockScalar -Block $case -Key 'expected_primary_agent'
        $expectedRisk = Get-YamlBlockScalar -Block $case -Key 'expected_risk_level'
        $expectedReviewers = Get-YamlBlockArray -Block $case -Key 'expected_review_agents'
        $requiredGates = Get-YamlBlockArray -Block $case -Key 'required_gates'
        $expectedBehavior = Get-YamlBlockArray -Block $case -Key 'expected_behavior'

        $workflowPath = Get-WorkflowPathById -WorkflowId $workflowId -Root $root
        if ([string]::IsNullOrWhiteSpace($workflowPath)) {
            Add-Failure "Case $caseId references missing workflow_id $workflowId"
            continue
        }

        $action = ''
        if ($expectedBehavior -contains 'block_external_send' -or $expectedBehavior -contains 'do_not_send_external_message') {
            $action = 'external_send'
        }
        if ($expectedBehavior -contains 'block_supplier_contact') {
            $action = 'supplier_contact'
        }
        if ($expectedBehavior -contains 'block_purchase_order') {
            $action = 'purchase_order'
        }

        $orchestratorArgs = @(
            '-ExecutionPolicy', 'Bypass',
            '-File', (Join-Path $PSScriptRoot 'invoke-orchestrator.ps1'),
            '-Workflow', $workflowPath,
            '-TaskId', "EVAL-$caseId",
            '-RiskHint', $expectedRisk
        )
        if (-not [string]::IsNullOrWhiteSpace($action)) {
            $orchestratorArgs += @('-RequestedAction', $action)
        }

        $json = & powershell @orchestratorArgs 2>&1
        if ($LASTEXITCODE -ne 0) {
            Add-Failure "Case $caseId could not invoke orchestrator: $json"
            continue
        }

        $result = $json | ConvertFrom-Json

        if ($result.primary_agent -ne $expectedPrimary) {
            Add-Failure "Case $caseId expected primary $expectedPrimary but got $($result.primary_agent)"
        }

        if ($result.risk_level -ne $expectedRisk) {
            Add-Failure "Case $caseId expected risk $expectedRisk but got $($result.risk_level)"
        }

        foreach ($reviewer in $expectedReviewers) {
            if (@($result.review_agents) -notcontains $reviewer) {
                Add-Failure "Case $caseId missing expected reviewer $reviewer"
            }
        }

        if ($requiredGates -contains 'approval_gate' -and $expectedRisk -eq 'high') {
            if (-not [bool]$result.approval_required) {
                Add-Failure "Case $caseId expected founder approval"
            }
            if ($null -eq $result.founder_approval_package) {
                Add-Failure "Case $caseId missing founder approval package"
            }
        }

        if ($requiredGates -contains 'evidence_gate') {
            if (@($result.audit_log_draft.evidence_paths).Count -eq 0) {
                Add-Failure "Case $caseId has no evidence paths"
            }
        }

        if ($requiredGates -contains 'output_gate') {
            if (@($result.allowed_output_paths).Count -eq 0) {
                Add-Failure "Case $caseId has no allowed output paths"
            }
        }

        if ($requiredGates -contains 'risk_gate' -and $expectedRisk -eq 'high') {
            if ($result.approval_state -ne 'pending_founder_approval') {
                Add-Failure "Case $caseId high risk did not enter pending founder approval"
            }
        }

        if ($requiredGates -contains 'evidence_gate' -and $expectedBehavior.Count -eq 0) {
            Add-Failure "Case $caseId has no expected behavior safeguards"
        }
    }
}

if ($failures.Count -gt 0) {
    Write-Host "Eval replay failed:" -ForegroundColor Red
    foreach ($failure in $failures) {
        Write-Host "- $failure" -ForegroundColor Red
    }
    exit 1
}

Write-Host "Eval replay passed. Cases: $caseCount"
