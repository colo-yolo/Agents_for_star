$ErrorActionPreference = 'Stop'

$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$source = Join-Path $root 'codex-skills/agents-for-star-orchestrator'
$target = Join-Path $env:USERPROFILE '.codex/skills/agents-for-star-orchestrator'
$failures = New-Object System.Collections.Generic.List[string]

function Add-Failure {
    param([string]$Message)
    [void]$failures.Add($Message)
}

function Test-SkillPath {
    param([string]$Path, [string]$Label)

    $skillFile = Join-Path $Path 'SKILL.md'
    if (-not (Test-Path -LiteralPath $skillFile)) {
        Add-Failure "$Label missing SKILL.md: $skillFile"
        return
    }

    $content = Get-Content -LiteralPath $skillFile -Raw -Encoding UTF8
    if ($content -notmatch "(?s)^---\s*\r?\n(?<frontmatter>.*?)\r?\n---") {
        Add-Failure "$Label has invalid SKILL.md frontmatter"
        return
    }

    $frontmatter = $Matches['frontmatter']
    if ($frontmatter -notmatch "(?m)^name:\s*agents-for-star-orchestrator\s*$") {
        Add-Failure "$Label skill name is not agents-for-star-orchestrator"
    }
    if ($frontmatter -notmatch "Product Manager Agent") {
        Add-Failure "$Label description does not mention role trigger names"
    }
}

Test-SkillPath -Path $source -Label 'source skill'
Test-SkillPath -Path $target -Label 'installed skill'

$sourceSkill = Join-Path $source 'SKILL.md'
$targetSkill = Join-Path $target 'SKILL.md'
if ((Test-Path -LiteralPath $sourceSkill) -and (Test-Path -LiteralPath $targetSkill)) {
    $sourceHash = (Get-FileHash -LiteralPath $sourceSkill -Algorithm SHA256).Hash
    $targetHash = (Get-FileHash -LiteralPath $targetSkill -Algorithm SHA256).Hash
    if ($sourceHash -ne $targetHash) {
        Add-Failure "installed SKILL.md differs from source"
    }
}

$requiredRepoFiles = @(
    'docs/codex-operator-playbook.md',
    'docs/agents/role-registry.md',
    'docs/agents/handoff-contract.md',
    'workflows/user-research-sprint.yaml',
    'workflows/phase-1-orchestrator-poc.yaml',
    'workflows/model-cost-eval.yaml',
    'workflows/hardware-principal-review.yaml',
    'workflows/principal-agent-review.yaml',
    'scripts/invoke-orchestrator.ps1',
    'scripts/validate-schemas.ps1',
    'scripts/run-evals.ps1',
    'scripts/validate-agent-capabilities.ps1',
    'docs/agents/principal-agent-capability-standard.md'
)

foreach ($path in $requiredRepoFiles) {
    if (-not (Test-Path -LiteralPath (Join-Path $root $path))) {
        Add-Failure "missing required repo file for local Codex dispatch: $path"
    }
}

$smoke = & powershell -ExecutionPolicy Bypass -File (Join-Path $root 'scripts/invoke-orchestrator.ps1') -Workflow (Join-Path $root 'workflows/user-research-sprint.yaml') -TaskId 'TASK-LOCAL-CODEX-SMOKE' -Goal 'local codex dispatch smoke' 2>&1
if ($LASTEXITCODE -ne 0) {
    Add-Failure "orchestrator smoke failed: $smoke"
} else {
    $result = $smoke | ConvertFrom-Json
    if ($result.primary_agent -ne 'Product Manager Agent') {
        Add-Failure "orchestrator smoke returned unexpected primary agent: $($result.primary_agent)"
    }
}

$principalSmoke = & powershell -ExecutionPolicy Bypass -File (Join-Path $root 'scripts/invoke-orchestrator.ps1') -Workflow (Join-Path $root 'workflows/principal-agent-review.yaml') -TaskId 'TASK-LOCAL-CODEX-PRINCIPAL-SMOKE' -Goal 'local codex principal agent review smoke' 2>&1
if ($LASTEXITCODE -ne 0) {
    Add-Failure "principal orchestrator smoke failed: $principalSmoke"
} else {
    $principalResult = $principalSmoke | ConvertFrom-Json
    if ($principalResult.primary_agent -ne 'Knowledge Ops Agent') {
        Add-Failure "principal orchestrator smoke returned unexpected primary agent: $($principalResult.primary_agent)"
    }
    if (-not [bool]$principalResult.approval_required) {
        Add-Failure "principal orchestrator smoke should require founder approval"
    }
}

if ($failures.Count -gt 0) {
    Write-Host "Local Codex agent verification failed:" -ForegroundColor Red
    foreach ($failure in $failures) {
        Write-Host "- $failure" -ForegroundColor Red
    }
    exit 1
}

Write-Host "Local Codex agent skill installed and verified."
