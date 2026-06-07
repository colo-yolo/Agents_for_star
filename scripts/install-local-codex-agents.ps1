$ErrorActionPreference = 'Stop'

$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$source = Join-Path $root 'codex-skills/agents-for-star-orchestrator'
$targetRoot = Join-Path $env:USERPROFILE '.codex/skills'
$target = Join-Path $targetRoot 'agents-for-star-orchestrator'

function Test-SkillFile {
    param([string]$SkillPath)

    $skillFile = Join-Path $SkillPath 'SKILL.md'
    if (-not (Test-Path -LiteralPath $skillFile)) {
        throw "Missing SKILL.md in $SkillPath"
    }

    $content = Get-Content -LiteralPath $skillFile -Raw -Encoding UTF8
    if (-not $content.StartsWith("---")) {
        throw "SKILL.md must start with YAML frontmatter"
    }
    if ($content -notmatch "(?s)^---\s*\r?\n(?<frontmatter>.*?)\r?\n---") {
        throw "SKILL.md frontmatter is not closed"
    }

    $frontmatter = $Matches['frontmatter']
    if ($frontmatter -notmatch "(?m)^name:\s*agents-for-star-orchestrator\s*$") {
        throw "SKILL.md frontmatter must contain name: agents-for-star-orchestrator"
    }
    if ($frontmatter -notmatch "(?m)^description:\s*.+") {
        throw "SKILL.md frontmatter must contain description"
    }
}

if (-not (Test-Path -LiteralPath $source)) {
    throw "Missing skill source: $source"
}

Test-SkillFile -SkillPath $source

New-Item -ItemType Directory -Force -Path $targetRoot | Out-Null

if (Test-Path -LiteralPath $target) {
    Remove-Item -LiteralPath $target -Recurse -Force
}

Copy-Item -LiteralPath $source -Destination $target -Recurse

Test-SkillFile -SkillPath $target

Write-Host "Installed agents-for-star-orchestrator skill to $target"
