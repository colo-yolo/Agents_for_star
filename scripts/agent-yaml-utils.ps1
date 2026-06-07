$ErrorActionPreference = 'Stop'

function Get-YamlLines {
    param([string]$Content)
    return @($Content -split "`r?`n")
}

function Get-YamlScalar {
    param(
        [string]$Content,
        [string]$Key
    )
    $escapedKey = [regex]::Escape($Key)
    foreach ($line in (Get-YamlLines $Content)) {
        if ($line -match "^$escapedKey\s*:\s*(.*)$") {
            return $Matches[1].Trim()
        }
    }
    return $null
}

function Get-YamlSectionLines {
    param(
        [string]$Content,
        [string]$Section
    )
    $escapedSection = [regex]::Escape($Section)
    $inSection = $false
    $result = New-Object System.Collections.Generic.List[string]

    foreach ($line in (Get-YamlLines $Content)) {
        if (-not $inSection) {
            if ($line -match "^$escapedSection\s*:\s*$") {
                $inSection = $true
            }
            continue
        }

        if ($line -match '^\S[^:]*\s*:') {
            break
        }

        [void]$result.Add($line)
    }

    return @($result)
}

function Get-YamlTopLevelArray {
    param(
        [string]$Content,
        [string]$Key
    )
    $escapedKey = [regex]::Escape($Key)
    $inArray = $false
    $result = New-Object System.Collections.Generic.List[string]

    foreach ($line in (Get-YamlLines $Content)) {
        if (-not $inArray) {
            if ($line -match "^$escapedKey\s*:\s*$") {
                $inArray = $true
            }
            continue
        }

        if ($line -match '^\S[^:]*\s*:') {
            break
        }

        if ($line -match '^\s*-\s+(.+)$') {
            [void]$result.Add($Matches[1].Trim())
        }
    }

    return @($result)
}

function Get-YamlNestedScalar {
    param(
        [string]$Content,
        [string]$Section,
        [string]$Key
    )
    $escapedKey = [regex]::Escape($Key)
    foreach ($line in (Get-YamlSectionLines -Content $Content -Section $Section)) {
        if ($line -match "^\s{2}$escapedKey\s*:\s*(.+)$") {
            return $Matches[1].Trim()
        }
    }
    return $null
}

function Get-YamlNestedArray {
    param(
        [string]$Content,
        [string]$Section,
        [string]$Key
    )
    $escapedKey = [regex]::Escape($Key)
    $inArray = $false
    $result = New-Object System.Collections.Generic.List[string]

    foreach ($line in (Get-YamlSectionLines -Content $Content -Section $Section)) {
        if (-not $inArray) {
            if ($line -match "^\s{2}$escapedKey\s*:\s*$") {
                $inArray = $true
            }
            continue
        }

        if ($line -match '^\s{2}\S[^:]*\s*:') {
            break
        }

        if ($line -match '^\s{4}-\s+(.+)$') {
            [void]$result.Add($Matches[1].Trim())
        }
    }

    return @($result)
}

function Get-YamlListItemBlocks {
    param(
        [string]$Content,
        [string]$Section
    )
    $sectionLines = Get-YamlSectionLines -Content $Content -Section $Section
    $blocks = New-Object System.Collections.ArrayList
    $current = $null

    foreach ($line in $sectionLines) {
        if ($line -match '^\s{2}-\s+') {
            if ($null -ne $current) {
                [void]$blocks.Add([string[]]$current.ToArray())
            }
            $current = New-Object System.Collections.Generic.List[string]
            [void]$current.Add($line)
            continue
        }

        if ($null -ne $current) {
            [void]$current.Add($line)
        }
    }

    if ($null -ne $current) {
        [void]$blocks.Add([string[]]$current.ToArray())
    }

    return $blocks.ToArray()
}

function Get-YamlBlockScalar {
    param(
        [string[]]$Block,
        [string]$Key
    )
    $escapedKey = [regex]::Escape($Key)
    foreach ($line in $Block) {
        if ($line -match "^\s*-\s+$escapedKey\s*:\s*(.+)$") {
            return $Matches[1].Trim()
        }
        if ($line -match "^\s+$escapedKey\s*:\s*(.+)$") {
            return $Matches[1].Trim()
        }
    }
    return $null
}

function Get-YamlBlockArray {
    param(
        [string[]]$Block,
        [string]$Key
    )
    $escapedKey = [regex]::Escape($Key)
    $inArray = $false
    $result = New-Object System.Collections.Generic.List[string]

    foreach ($line in $Block) {
        if (-not $inArray) {
            if ($line -match "^\s+$escapedKey\s*:\s*$") {
                $inArray = $true
            }
            continue
        }

        if ($line -match '^\s{4}\S[^:]*\s*:') {
            break
        }

        if ($line -match '^\s{6}-\s+(.+)$') {
            [void]$result.Add($Matches[1].Trim())
        }
    }

    return @($result)
}

function Get-WorkflowPathById {
    param(
        [string]$WorkflowId,
        [string]$Root
    )
    $workflowFiles = Get-ChildItem -LiteralPath (Join-Path $Root 'workflows') -Filter '*.yaml' -File
    foreach ($workflowFile in $workflowFiles) {
        $content = Get-Content -LiteralPath $workflowFile.FullName -Raw -Encoding UTF8
        if ((Get-YamlScalar -Content $content -Key 'workflow_id') -eq $WorkflowId) {
            return $workflowFile.FullName
        }
    }
    return $null
}

function ConvertTo-RepoRelativePath {
    param(
        [string]$Path,
        [string]$Root
    )
    $resolvedRoot = (Resolve-Path -LiteralPath $Root).Path
    $resolvedPath = (Resolve-Path -LiteralPath $Path).Path
    return $resolvedPath.Substring($resolvedRoot.Length).TrimStart('\', '/')
}
