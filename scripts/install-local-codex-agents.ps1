$ErrorActionPreference = 'Stop'

$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$source = Join-Path $root 'codex-skills/agents-for-star-orchestrator'
$targetRoot = Join-Path $env:USERPROFILE '.codex/skills'
$target = Join-Path $targetRoot 'agents-for-star-orchestrator'
$pluginName = 'agents-for-star'
$marketplaceName = 'agents-for-star-local'
$pluginRoot = Join-Path $root "plugins/$pluginName"
$marketplacePath = Join-Path $root '.agents/plugins/marketplace.json'

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

& powershell -ExecutionPolicy Bypass -File (Join-Path $root 'scripts/build-local-codex-agent-plugin.ps1')
if ($LASTEXITCODE -ne 0) {
    throw "Failed to build local Codex plugin"
}

if (-not (Test-Path -LiteralPath (Join-Path $pluginRoot '.codex-plugin/plugin.json'))) {
    throw "Missing plugin manifest after build: $pluginRoot"
}
if (-not (Test-Path -LiteralPath $marketplacePath)) {
    throw "Missing marketplace after build: $marketplacePath"
}

$validator = Join-Path $env:USERPROFILE '.codex/skills/.system/plugin-creator/scripts/validate_plugin.py'
if (Test-Path -LiteralPath $validator) {
    $pythonCommand = $null
    try {
        $pyProbe = & py --version 2>&1
        if ($LASTEXITCODE -eq 0) {
            $pythonCommand = 'py'
        }
    } catch {
        $pythonCommand = $null
    }
    if ($null -eq $pythonCommand) {
        $pythonCommand = 'python'
    }

    & $pythonCommand $validator $pluginRoot
    if ($LASTEXITCODE -ne 0) {
        throw "Plugin validation failed: $pluginRoot"
    }
}

New-Item -ItemType Directory -Force -Path $targetRoot | Out-Null

if (Test-Path -LiteralPath $target) {
    Remove-Item -LiteralPath $target -Recurse -Force
}

Copy-Item -LiteralPath $source -Destination $target -Recurse

Test-SkillFile -SkillPath $target

$marketplaceList = & codex plugin marketplace list 2>&1
if ($LASTEXITCODE -ne 0) {
    throw "Failed to list Codex plugin marketplaces: $marketplaceList"
}

$marketplaceLine = $marketplaceList | Where-Object { $_ -match "^$([regex]::Escape($marketplaceName))\s+" } | Select-Object -First 1
if (-not $marketplaceLine) {
    & codex plugin marketplace add $root
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to add Codex plugin marketplace: $root"
    }
} elseif ($marketplaceLine -notmatch [regex]::Escape($root)) {
    throw "Codex marketplace '$marketplaceName' already exists but does not point at this repo: $marketplaceLine"
}

& codex plugin remove "$pluginName@$marketplaceName" 2>$null
& codex plugin add "$pluginName@$marketplaceName"
if ($LASTEXITCODE -ne 0) {
    throw "Failed to install Codex plugin $pluginName@$marketplaceName"
}

Write-Host "Installed agents-for-star-orchestrator skill to $target"
Write-Host "Installed $pluginName@$marketplaceName from $pluginRoot"
