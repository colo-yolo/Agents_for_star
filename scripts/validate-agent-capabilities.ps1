$ErrorActionPreference = 'Stop'

$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$roleDir = Join-Path $root 'docs/agents/roles'
$failures = New-Object System.Collections.Generic.List[string]

function Add-Failure {
    param([string]$Message)
    [void]$failures.Add($Message)
}

function New-Utf8Text {
    param([int[]]$Codepoints)
    $chars = foreach ($codepoint in $Codepoints) {
        [char]$codepoint
    }
    return [string]::Concat($chars)
}

$requiredSections = @(
    ('## ' + (New-Utf8Text @(0x4F7F, 0x547D)))
    ('## ' + (New-Utf8Text @(0x804C, 0x8D23, 0x8FB9, 0x754C)))
    ('## ' + (New-Utf8Text @(0x8F93, 0x5165)))
    ('## ' + (New-Utf8Text @(0x8F93, 0x51FA)))
    ('## ' + (New-Utf8Text @(0x5DE5, 0x5177, 0x6743, 0x9650)))
    ('## ' + (New-Utf8Text @(0x7981, 0x6B62, 0x52A8, 0x4F5C)))
    ('## ' + (New-Utf8Text @(0x5347, 0x7EA7, 0x5BA1, 0x6279, 0x6761, 0x4EF6)))
    ('## ' + (New-Utf8Text @(0x5931, 0x8D25, 0x5904, 0x7406)))
    ('## ' + (New-Utf8Text @(0x6307, 0x6807)))
    ('## Principal ' + (New-Utf8Text @(0x7EA7, 0x5DE5, 0x4F5C, 0x65B9, 0x5F0F)))
)

$advancedSections = @(
    ('## ' + (New-Utf8Text @(0x51B3, 0x7B56, 0x95E8, 0x63A7)))
    ('## ' + (New-Utf8Text @(0x9AD8, 0x7EA7, 0x4EA4, 0x4ED8, 0x7269)))
    ('## ' + (New-Utf8Text @(0x8BC1, 0x636E, 0x94FE, 0x8981, 0x6C42)))
    ('## ' + (New-Utf8Text @(0x53CD, 0x6A21, 0x5F0F)))
)

$requiredTerms = @(
    ([string][char]0x521B + [string][char]0x59CB + [string][char]0x4EBA + [string][char]0x5BA1 + [string][char]0x6279),
    ([string][char]0x8BC1 + [string][char]0x636E),
    ([string][char]0x5F85 + [string][char]0x9A8C + [string][char]0x8BC1),
    ([string][char]0x9AD8 + [string][char]0x98CE + [string][char]0x9669)
)

$roleFiles = Get-ChildItem -LiteralPath $roleDir -Filter '*.md' -File
if ($roleFiles.Count -ne 16) {
    Add-Failure "Expected 16 role files, found $($roleFiles.Count)"
}

foreach ($roleFile in $roleFiles) {
    $content = Get-Content -LiteralPath $roleFile.FullName -Raw -Encoding UTF8
    foreach ($section in $requiredSections) {
        if (-not $content.Contains($section)) {
            Add-Failure "$($roleFile.Name) missing section $section"
        }
    }

    if ($roleFile.Name -ne 'hardware-architect-agent.md') {
        foreach ($section in $advancedSections) {
            if (-not $content.Contains($section)) {
                Add-Failure "$($roleFile.Name) missing advanced section $section"
            }
        }
    }

    foreach ($term in $requiredTerms) {
        if (-not $content.Contains($term)) {
            Add-Failure "$($roleFile.Name) missing required term $term"
        }
    }
}

if ($failures.Count -gt 0) {
    Write-Host "Agent capability validation failed:" -ForegroundColor Red
    foreach ($failure in $failures) {
        Write-Host "- $failure" -ForegroundColor Red
    }
    exit 1
}

Write-Host "Agent capability validation passed."
