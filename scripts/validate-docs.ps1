$ErrorActionPreference = 'Stop'

$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
Set-Location $root

$failures = New-Object System.Collections.Generic.List[string]

function Add-Failure {
    param([string]$Message)
    [void]$failures.Add($Message)
}

function Test-RequiredPath {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) {
        Add-Failure "Missing required path: $Path"
    }
}

$requiredDirs = @(
    'docs/research',
    'docs/agents/roles',
    'docs/orchestrator',
    'docs/phase-1-poc',
    'docs/evaluation',
    'docs/references',
    'docs/audit',
    'docs/examples',
    'codex-skills',
    'schemas',
    'workflows',
    'evals',
    'plugins',
    '.github/workflows',
    '.github/ISSUE_TEMPLATE',
    'scripts'
)

$requiredFiles = @(
    'README.md',
    'AGENTS.md',
    'docs/research/interview-record-template.md',
    'docs/research/pain-scorecard.md',
    'docs/research/hardware-acceptance-scorecard.md',
    'docs/research/pilot-interest-board.md',
    'docs/research/main-scenario-decision.md',
    'docs/orchestrator/task-routing-protocol.md',
    'docs/orchestrator/approval-state-machine.md',
    'docs/orchestrator/audit-log-schema.md',
    'docs/orchestrator/tool-permission-model.md',
    'docs/orchestrator/memory-and-context-policy.md',
    'docs/orchestrator/workflow-spec.md',
    'docs/orchestrator/runtime-options.md',
    'docs/phase-1-poc/architecture.md',
    'docs/phase-1-poc/device-input-simulator.md',
    'docs/phase-1-poc/founder-approval-flow.md',
    'docs/phase-1-poc/demo-script.md',
    'docs/phase-1-poc/test-plan.md',
    'docs/phase-1-poc/acceptance-checklist.md',
    'docs/evaluation/agent-output-rubric.md',
    'docs/evaluation/task-replay-cases.md',
    'docs/evaluation/failure-taxonomy.md',
    'docs/evaluation/model-cost-quality-tracker.md',
    'docs/evaluation/eval-ci-gate.md',
    'docs/references/open-source-agent-patterns.md',
    'docs/references/hardware-engineering-patterns.md',
    'docs/codex-operator-playbook.md',
    'docs/local-codex-agent-setup.md',
    'docs/audit/README.md',
    'docs/audit/examples/handoff-package-example.yaml',
    'docs/audit/examples/approval-package-example.yaml',
    'docs/audit/examples/audit-log-example.md',
    'docs/examples/user-research-sprint.md',
    'docs/examples/poc-demo.md',
    'docs/examples/bom-risk-review.md',
    'docs/examples/customer-email-approval.md',
    'docs/examples/model-cost-evaluation.md',
    'docs/examples/privacy-policy-change.md',
    'docs/hardware/hardware-principal-playbook.md',
    'docs/hardware/hardware-design-review-checklist.md',
    'docs/hardware/hardware-bringup-evt-plan.md',
    'docs/hardware/hardware-fmea-template.md',
    'docs/hardware/hardware-interface-control-document.md',
    'docs/agents/handoff-contract.md',
    'docs/agents/principal-agent-capability-standard.md',
    'workflows/user-research-sprint.yaml',
    'workflows/phase-1-orchestrator-poc.yaml',
    'workflows/model-cost-eval.yaml',
    'workflows/hardware-principal-review.yaml',
    'workflows/principal-agent-review.yaml',
    'evals/agent-routing-evals.yaml',
    'evals/hardware-agent-evals.yaml',
    'evals/principal-agent-capability-evals.yaml',
    'schemas/workflow.schema.json',
    'schemas/eval.schema.json',
    'schemas/handoff-package.schema.json',
    'schemas/approval-package.schema.json',
    'scripts/agent-yaml-utils.ps1',
    'scripts/invoke-orchestrator.ps1',
    'scripts/validate-schemas.ps1',
    'scripts/run-evals.ps1',
    'scripts/install-local-codex-agents.ps1',
    'scripts/verify-local-codex-agents.ps1',
    'scripts/build-local-codex-agent-plugin.ps1',
    'scripts/validate-agent-capabilities.ps1',
    'codex-skills/agents-for-star-orchestrator/SKILL.md',
    'codex-skills/agents-for-star-orchestrator/agents/openai.yaml',
    '.agents/plugins/marketplace.json',
    'plugins/agents-for-star/.codex-plugin/plugin.json',
    'plugins/agents-for-star/skills/star-orchestrator/SKILL.md',
    'plugins/agents-for-star/skills/star-product-manager/SKILL.md',
    'plugins/agents-for-star/skills/star-hardware-architect/SKILL.md',
    'plugins/agents-for-star/skills/star-security/SKILL.md',
    '.github/workflows/validate.yml',
    'docs/security/access-control-matrix.md',
    'docs/compliance/data-retention-policy-draft.md',
    'docs/compliance/founder-approval-policy.md',
    'docs/operations/weekly-review-template.md',
    'docs/operations/decision-dashboard.md',
    'docs/finance/cashflow-scenario-template.md',
    '.github/ISSUE_TEMPLATE/bug_report.md',
    '.github/ISSUE_TEMPLATE/feature_request.md',
    '.github/ISSUE_TEMPLATE/research.md',
    '.github/ISSUE_TEMPLATE/risk.md',
    '.github/ISSUE_TEMPLATE/decision.md',
    '.github/pull_request_template.md',
    'scripts/validate-docs.ps1',
    'docs/codex-goals/master-roadmap.md'
)

$roleFiles = @(
    'ceo-strategy-agent.md',
    'product-manager-agent.md',
    'hardware-architect-agent.md',
    'firmware-agent.md',
    'ai-ml-agent.md',
    'backend-agent.md',
    'app-ux-agent.md',
    'qa-reliability-agent.md',
    'supply-chain-agent.md',
    'compliance-agent.md',
    'security-agent.md',
    'finance-agent.md',
    'marketing-agent.md',
    'sales-agent.md',
    'customer-success-agent.md',
    'knowledge-ops-agent.md'
)

foreach ($dir in $requiredDirs) {
    Test-RequiredPath $dir
}

foreach ($file in $requiredFiles) {
    Test-RequiredPath $file
}

foreach ($role in $roleFiles) {
    Test-RequiredPath (Join-Path 'docs/agents/roles' $role)
}

$roadmapPath = 'docs/codex-goals/master-roadmap.md'
if (Test-Path -LiteralPath $roadmapPath) {
    $goalCount = ([regex]::Matches((Get-Content -LiteralPath $roadmapPath -Raw -Encoding UTF8), '/goal')).Count
    if ($goalCount -lt 6) {
        Add-Failure "Expected at least 6 /goal prompts in $roadmapPath, found $goalCount"
    }
}

$gitRoot = Join-Path $root '.git'
$scanFiles = Get-ChildItem -LiteralPath $root -Recurse -File |
    Where-Object {
        $_.FullName -notlike "$gitRoot*" -and
        $_.Extension -in @('.md', '.ps1', '.yml', '.yaml')
    }

$bannedTerms = @(
    'TO'+'DO',
    'T'+'BD',
    'PLACE'+'HOLDER',
    ([string][char]0x5F85 + [string][char]0x8865 + [string][char]0x5145)
)
$garbledTerms = @(
    [string][char]0xFFFD,
    [string][char]0x93C5,
    ([string][char]0x6D93 + [string][char]0x20AC)
)
$patterns = $bannedTerms + $garbledTerms

foreach ($file in $scanFiles) {
    $content = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
    foreach ($pattern in $patterns) {
        if ($content.Contains($pattern)) {
            $relative = Resolve-Path -LiteralPath $file.FullName -Relative
            Add-Failure "Found banned or garbled text '$pattern' in $relative"
        }
    }
}

$previousErrorActionPreference = $ErrorActionPreference
$ErrorActionPreference = 'Continue'
$diffCheck = & git diff --check 2>&1
$diffCheckExitCode = $LASTEXITCODE
$ErrorActionPreference = $previousErrorActionPreference
if ($diffCheckExitCode -ne 0) {
    Add-Failure "git diff --check failed:`n$diffCheck"
}

if ($failures.Count -gt 0) {
    Write-Host "Document validation failed:" -ForegroundColor Red
    foreach ($failure in $failures) {
        Write-Host "- $failure" -ForegroundColor Red
    }
    exit 1
}

Write-Host "Document validation passed."
