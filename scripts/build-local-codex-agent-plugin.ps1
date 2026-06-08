$ErrorActionPreference = 'Stop'

$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$pluginName = 'agents-for-star'
$marketplaceName = 'agents-for-star-local'
$pluginRoot = Join-Path $root "plugins/$pluginName"
$skillsRoot = Join-Path $pluginRoot 'skills'
$marketplacePath = Join-Path $root '.agents/plugins/marketplace.json'
$repoPath = $root
$uiMetadataPath = Join-Path $root 'docs/agents/local-codex-slash-ui.zh-CN.json'

function Write-Utf8File {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Content
    )

    $parent = Split-Path -Parent $Path
    if (-not [string]::IsNullOrWhiteSpace($parent)) {
        New-Item -ItemType Directory -Force -Path $parent | Out-Null
    }

    $normalized = $Content -replace "`r?`n", "`n"
    $encoding = [System.Text.UTF8Encoding]::new($false)
    [System.IO.File]::WriteAllText($Path, $normalized, $encoding)
}

function ConvertTo-JsonFile {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)]$Value
    )

    $json = $Value | ConvertTo-Json -Depth 20
    Write-Utf8File -Path $Path -Content ($json + "`n")
}

function ConvertTo-YamlSingleQuoted {
    param([Parameter(Mandatory = $true)][string]$Value)
    return "'" + ($Value -replace "'", "''") + "'"
}

function Remove-GeneratedPluginRoot {
    if (-not (Test-Path -LiteralPath $pluginRoot)) {
        return
    }

    $resolvedRoot = [System.IO.Path]::GetFullPath($root)
    $resolvedPlugin = [System.IO.Path]::GetFullPath($pluginRoot)
    if (-not $resolvedPlugin.StartsWith($resolvedRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing to remove plugin path outside workspace: $resolvedPlugin"
    }
    if ($resolvedPlugin -eq $resolvedRoot) {
        throw "Refusing to remove workspace root"
    }

    Remove-Item -LiteralPath $resolvedPlugin -Recurse -Force
}

function New-StarSkill {
    param(
        [Parameter(Mandatory = $true)][string]$SkillName,
        [Parameter(Mandatory = $true)][string]$Title,
        [Parameter(Mandatory = $true)][string]$Description,
        [Parameter(Mandatory = $true)][string]$DisplayName,
        [Parameter(Mandatory = $true)][string]$ShortDescription,
        [Parameter(Mandatory = $true)][string]$DefaultPrompt,
        [Parameter(Mandatory = $true)][string]$Body
    )

    $skillDir = Join-Path $skillsRoot $SkillName
    $skillContent = @(
        '---',
        "name: $SkillName",
        ('description: ' + (ConvertTo-YamlSingleQuoted $Description)),
        '---',
        '',
        "# $Title",
        '',
        $Body
    ) -join "`n"

    $agentYaml = @(
        'interface:',
        ('  display_name: ' + (ConvertTo-YamlSingleQuoted $DisplayName)),
        ('  short_description: ' + (ConvertTo-YamlSingleQuoted $ShortDescription)),
        '  icon_small: ./assets/star-agent-small.svg',
        '  icon_large: ./assets/star-agent.svg',
        ('  default_prompt: ' + (ConvertTo-YamlSingleQuoted $DefaultPrompt)),
        'policy:',
        '  allow_implicit_invocation: false'
    ) -join "`n"

    Write-Utf8File -Path (Join-Path $skillDir 'SKILL.md') -Content ($skillContent + "`n")
    Write-Utf8File -Path (Join-Path $skillDir 'agents/openai.yaml') -Content ($agentYaml + "`n")
    Write-Utf8File -Path (Join-Path $skillDir 'assets/star-agent-small.svg') -Content $smallIconSvg
    Write-Utf8File -Path (Join-Path $skillDir 'assets/star-agent.svg') -Content $largeIconSvg
}

if (-not (Test-Path -LiteralPath $uiMetadataPath)) {
    throw "Missing local Codex slash UI metadata: $uiMetadataPath"
}

$uiMetadata = Get-Content -LiteralPath $uiMetadataPath -Raw -Encoding UTF8 | ConvertFrom-Json
$largeIconSvg = @(
    '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">',
    '  <defs>',
    '    <linearGradient id="g" x1="96" y1="80" x2="420" y2="432" gradientUnits="userSpaceOnUse">',
    '      <stop stop-color="#2563EB"/>',
    '      <stop offset="0.55" stop-color="#14B8A6"/>',
    '      <stop offset="1" stop-color="#F59E0B"/>',
    '    </linearGradient>',
    '  </defs>',
    '  <rect width="512" height="512" rx="96" fill="#0F172A"/>',
    '  <path d="M256 74l38 116 122 1-98 71 37 117-99-72-99 72 37-117-98-71 122-1 38-116z" fill="url(#g)"/>',
    '  <circle cx="256" cy="256" r="64" fill="#F8FAFC"/>',
    '  <path d="M220 258h112M256 202v112" stroke="#0F172A" stroke-width="26" stroke-linecap="round"/>',
    '</svg>'
) -join "`n"
$smallIconSvg = @(
    '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64">',
    '  <rect width="64" height="64" rx="14" fill="#0F172A"/>',
    '  <path d="M32 8l6.8 20.8h21.9L42.9 41.6l6.8 20.8L32 49.6 14.3 62.4l6.8-20.8L3.3 28.8h21.9L32 8z" fill="#38BDF8"/>',
    '  <circle cx="32" cy="34" r="8" fill="#F8FAFC"/>',
    '</svg>'
) -join "`n"

Remove-GeneratedPluginRoot

$pluginJson = [ordered]@{
    name = $pluginName
    version = '0.1.1'
    description = 'Local Codex plugin for dispatching Agents for Star Principal-level role workflows.'
    author = [ordered]@{
        name = 'Agents for Star'
    }
    homepage = 'https://github.com/colo-yolo/Agents_for_star'
    repository = 'https://github.com/colo-yolo/Agents_for_star'
    license = 'MIT'
    keywords = @(
        'codex',
        'agents',
        'workflow',
        'principal-agent',
        'hardware',
        'orchestrator'
    )
    skills = './skills/'
    interface = [ordered]@{
        displayName = $uiMetadata.plugin.displayName
        shortDescription = $uiMetadata.plugin.shortDescription
        longDescription = $uiMetadata.plugin.longDescription
        developerName = 'Agents for Star'
        category = 'Developer Tools'
        capabilities = @('Interactive', 'Read', 'Write')
        defaultPrompt = @($uiMetadata.plugin.defaultPrompts)
        brandColor = '#2563EB'
        composerIcon = './assets/star-agent-small.svg'
        logo = './assets/star-agent.svg'
        screenshots = @()
    }
}

$marketplace = [ordered]@{
    name = $marketplaceName
    interface = [ordered]@{
        displayName = $uiMetadata.plugin.marketplaceDisplayName
    }
    plugins = @(
        [ordered]@{
            name = $pluginName
            source = [ordered]@{
                source = 'local'
                path = "./plugins/$pluginName"
            }
            policy = [ordered]@{
                installation = 'AVAILABLE'
                authentication = 'ON_INSTALL'
            }
            category = 'Developer Tools'
        }
    )
}

ConvertTo-JsonFile -Path (Join-Path $pluginRoot '.codex-plugin/plugin.json') -Value $pluginJson
ConvertTo-JsonFile -Path $marketplacePath -Value $marketplace
Write-Utf8File -Path (Join-Path $pluginRoot 'assets/star-agent-small.svg') -Content $smallIconSvg
Write-Utf8File -Path (Join-Path $pluginRoot 'assets/star-agent.svg') -Content $largeIconSvg
Write-Utf8File -Path (Join-Path $pluginRoot 'agents/openai.yaml') -Content ((@(
    'interface:',
    ('  display_name: ' + (ConvertTo-YamlSingleQuoted $uiMetadata.plugin.displayName)),
    ('  short_description: ' + (ConvertTo-YamlSingleQuoted $uiMetadata.plugin.shortDescription)),
    '  icon_small: ./assets/star-agent-small.svg',
    '  icon_large: ./assets/star-agent.svg',
    ('  default_prompt: ' + (ConvertTo-YamlSingleQuoted $uiMetadata.plugin.defaultPrompts[0]))
) -join "`n") + "`n")

$commonPreamble = @(
    '## Operating Contract',
    '',
    'This slash skill dispatches local Agents for Star role work from Codex.',
    "Repository path: $repoPath",
    '',
    'Required fact sources:',
    '',
    '- AGENTS.md',
    '- docs/codex-operator-playbook.md',
    '- docs/agents/principal-agent-capability-standard.md',
    '- docs/agents/role-registry.md',
    '- docs/agents/handoff-contract.md',
    '',
    'User-facing planning, summaries, and deliverables must be written in Chinese unless the user asks otherwise.',
    'Do not fabricate market data, supplier quotes, certification costs, legal conclusions, model pricing, customer feedback, or private facts.',
    'High-risk actions stop at a founder approval package. Do not execute payment, contract signing, external send, privacy policy change, security exception, production secret use, or mass production commitment.',
    '',
    '## Verification Before Completion',
    '',
    'Run or report why you cannot run:',
    '',
    '- git diff --check',
    '- powershell -ExecutionPolicy Bypass -File scripts\validate-docs.ps1',
    '- powershell -ExecutionPolicy Bypass -File scripts\validate-agent-capabilities.ps1',
    '- powershell -ExecutionPolicy Bypass -File scripts\validate-schemas.ps1',
    '- powershell -ExecutionPolicy Bypass -File scripts\run-evals.ps1',
    '- powershell -ExecutionPolicy Bypass -File scripts\verify-local-codex-agents.ps1'
) -join "`n"

$orchestratorBody = @(
    $commonPreamble,
    '',
    '## Dispatch Steps',
    '',
    '1. Match the user goal to the closest workflows/*.yaml file.',
    '2. Run scripts/invoke-orchestrator.ps1 with Workflow, TaskId, and Goal.',
    '3. Read the returned primary_agent and review_agents role protocols from docs/agents/roles/.',
    '4. Produce a dispatch result, primary Agent draft, reviewer critiques, evidence paths, risk level, approval state, and verification record.',
    '5. If no workflow fits, use docs/agents/role-registry.md to choose one primary Agent plus reviewers, then propose a new workflow instead of inventing routing behavior.',
    '',
    '## Common Workflows',
    '',
    '| Scenario | Workflow |',
    '|---|---|',
    '| User research | workflows/user-research-sprint.yaml |',
    '| POC Orchestrator | workflows/phase-1-orchestrator-poc.yaml |',
    '| Model cost eval | workflows/model-cost-eval.yaml |',
    '| Hardware principal review | workflows/hardware-principal-review.yaml |',
    '| Agent capability or local Codex dispatch review | workflows/principal-agent-review.yaml |'
) -join "`n"

New-StarSkill `
    -SkillName 'star-orchestrator' `
    -Title 'Star Orchestrator' `
    -Description $uiMetadata.skills.'star-orchestrator'.skillDescription `
    -DisplayName $uiMetadata.skills.'star-orchestrator'.displayName `
    -ShortDescription $uiMetadata.skills.'star-orchestrator'.shortDescription `
    -DefaultPrompt $uiMetadata.skills.'star-orchestrator'.defaultPrompt `
    -Body $orchestratorBody

$roles = @(
    [ordered]@{ Skill='star-ceo-strategy'; Title='CEO Strategy Agent'; Role='CEO Strategy Agent'; File='ceo-strategy-agent.md'; Workflow='workflows/principal-agent-review.yaml'; Reviewers='Product Manager Agent, Finance Agent, Knowledge Ops Agent, Compliance Agent'; Triggers='strategy, roadmap, OKR, resource allocation, founder decisions, budget tradeoffs, company direction'; Prompt='Use /star-ceo-strategy to review roadmap and resource tradeoffs.' },
    [ordered]@{ Skill='star-product-manager'; Title='Product Manager Agent'; Role='Product Manager Agent'; File='product-manager-agent.md'; Workflow='workflows/user-research-sprint.yaml'; Reviewers='Customer Success Agent, Compliance Agent, QA Reliability Agent'; Triggers='PRD, product requirements, user research, MVP scope, acceptance criteria, main scenario decisions'; Prompt='Use /star-product-manager to refine PRD and MVP scope.' },
    [ordered]@{ Skill='star-hardware-architect'; Title='Hardware Architect Agent'; Role='Hardware Architect Agent'; File='hardware-architect-agent.md'; Workflow='workflows/hardware-principal-review.yaml'; Reviewers='Supply Chain Agent, Security Agent, Firmware Agent, QA Reliability Agent, Finance Agent'; Triggers='hardware architecture, BOM, PCB, sensors, power, thermal, EVT, bring-up, FMEA'; Prompt='Use /star-hardware-architect for Principal hardware review.' },
    [ordered]@{ Skill='star-firmware'; Title='Firmware Agent'; Role='Firmware Agent'; File='firmware-agent.md'; Workflow='workflows/hardware-principal-review.yaml'; Reviewers='Hardware Architect Agent, Security Agent, QA Reliability Agent, Backend Agent'; Triggers='firmware, OTA, state machine, logs, low power, secure boot, device input protocol'; Prompt='Use /star-firmware to review device firmware behavior.' },
    [ordered]@{ Skill='star-ai-ml'; Title='AI ML Agent'; Role='AI ML Agent'; File='ai-ml-agent.md'; Workflow='workflows/model-cost-eval.yaml'; Reviewers='Security Agent, Finance Agent, Product Manager Agent'; Triggers='model strategy, prompt, eval, model cost, AI output quality, human escalation, sensitive data'; Prompt='Use /star-ai-ml to evaluate model strategy and cost.' },
    [ordered]@{ Skill='star-backend'; Title='Backend Agent'; Role='Backend Agent'; File='backend-agent.md'; Workflow='workflows/phase-1-orchestrator-poc.yaml'; Reviewers='Security Agent, QA Reliability Agent, AI ML Agent, Firmware Agent'; Triggers='backend, Orchestrator, API, audit log, permissions, task routing, approval state'; Prompt='Use /star-backend to design Orchestrator and audit flow.' },
    [ordered]@{ Skill='star-app-ux'; Title='App UX Agent'; Role='App UX Agent'; File='app-ux-agent.md'; Workflow='workflows/phase-1-orchestrator-poc.yaml'; Reviewers='Product Manager Agent, Compliance Agent, Customer Success Agent'; Triggers='UX, UI flow, approval interface, device status, risk copy, usability, customer-visible text'; Prompt='Use /star-app-ux to design approval and device status flows.' },
    [ordered]@{ Skill='star-qa-reliability'; Title='QA Reliability Agent'; Role='QA Reliability Agent'; File='qa-reliability-agent.md'; Workflow='workflows/phase-1-orchestrator-poc.yaml'; Reviewers='Product Manager Agent, Firmware Agent, Backend Agent'; Triggers='QA, test plan, regression, release gate, defect taxonomy, reliability, replay cases'; Prompt='Use /star-qa-reliability to build release gates and replay tests.' },
    [ordered]@{ Skill='star-supply-chain'; Title='Supply Chain Agent'; Role='Supply Chain Agent'; File='supply-chain-agent.md'; Workflow='workflows/hardware-principal-review.yaml'; Reviewers='Hardware Architect Agent, Finance Agent, Compliance Agent'; Triggers='BOM, supplier, alternate parts, MOQ, lead time, procurement, purchase approval'; Prompt='Use /star-supply-chain to review BOM and procurement risk.' },
    [ordered]@{ Skill='star-compliance'; Title='Compliance Agent'; Role='Compliance Agent'; File='compliance-agent.md'; Workflow='workflows/user-research-sprint.yaml'; Reviewers='Security Agent, Product Manager Agent, App UX Agent'; Triggers='privacy, compliance, certification, data retention, external claims, legal review questions'; Prompt='Use /star-compliance to review privacy and compliance risk.' },
    [ordered]@{ Skill='star-security'; Title='Security Agent'; Role='Security Agent'; File='security-agent.md'; Workflow='workflows/phase-1-orchestrator-poc.yaml'; Reviewers='Backend Agent, Firmware Agent, Compliance Agent'; Triggers='security, threat model, permissions, secrets, least privilege, tool guardrails, security exception'; Prompt='Use /star-security to review threat model and permissions.' },
    [ordered]@{ Skill='star-finance'; Title='Finance Agent'; Role='Finance Agent'; File='finance-agent.md'; Workflow='workflows/model-cost-eval.yaml'; Reviewers='CEO Strategy Agent, Supply Chain Agent, AI ML Agent'; Triggers='finance, budget, cash flow, unit economics, payment approval, cost assumptions, runway'; Prompt='Use /star-finance to review budget and cash-flow impact.' },
    [ordered]@{ Skill='star-marketing'; Title='Marketing Agent'; Role='Marketing Agent'; File='marketing-agent.md'; Workflow='workflows/principal-agent-review.yaml'; Reviewers='Product Manager Agent, Sales Agent, Compliance Agent'; Triggers='marketing, positioning, content, launch copy, claims review, public messaging'; Prompt='Use /star-marketing to draft positioning with claim review.' },
    [ordered]@{ Skill='star-sales'; Title='Sales Agent'; Role='Sales Agent'; File='sales-agent.md'; Workflow='workflows/user-research-sprint.yaml'; Reviewers='Marketing Agent, Customer Success Agent, Product Manager Agent, Finance Agent'; Triggers='sales, ICP, leads, demo, pipeline, customer email, quote, pilot agreement'; Prompt='Use /star-sales to prepare demo or customer follow-up drafts.' },
    [ordered]@{ Skill='star-customer-success'; Title='Customer Success Agent'; Role='Customer Success Agent'; File='customer-success-agent.md'; Workflow='workflows/user-research-sprint.yaml'; Reviewers='Product Manager Agent, QA Reliability Agent, Sales Agent'; Triggers='customer success, pilot feedback, support draft, issue reproduction, value validation, customer risk'; Prompt='Use /star-customer-success to process pilot feedback.' },
    [ordered]@{ Skill='star-knowledge-ops'; Title='Knowledge Ops Agent'; Role='Knowledge Ops Agent'; File='knowledge-ops-agent.md'; Workflow='workflows/principal-agent-review.yaml'; Reviewers='CEO Strategy Agent, QA Reliability Agent, Compliance Agent'; Triggers='knowledge ops, docs, decision records, audit logs, weekly review, goal prompt, fact source cleanup'; Prompt='Use /star-knowledge-ops to organize docs and next /goal.' }
)

foreach ($role in $roles) {
    $roleUi = $uiMetadata.skills.($role.Skill)
    if ($null -eq $roleUi) {
        throw "Missing UI metadata for skill: $($role.Skill)"
    }

    $body = @(
        $commonPreamble,
        '',
        '## Role Entry',
        '',
        "Use this skill when the user invokes /$($role.Skill) or asks for $($role.Role).",
        '',
        "1. Read docs/agents/roles/$($role.File).",
        '2. Apply docs/agents/principal-agent-capability-standard.md before drafting output.',
        "3. Default workflow: $($role.Workflow).",
        "4. Preferred review Agents: $($role.Reviewers).",
        '5. Produce the dispatch result, primary Agent draft, reviewer critiques, evidence path, risk level, approval state, and verification record.',
        '',
        '## Trigger Keywords',
        '',
        $role.Triggers,
        '',
        '## Output Boundary',
        '',
        '- Use only repository fact sources or clearly label missing and unverified facts according to repo rules.',
        '- If the task touches a high-risk action, stop at a founder approval package.',
        '- Do not execute external actions or make commercial, legal, compliance, security, or manufacturing commitments.'
    ) -join "`n"

    New-StarSkill `
        -SkillName $role.Skill `
        -Title $role.Title `
        -Description $roleUi.skillDescription `
        -DisplayName $roleUi.displayName `
        -ShortDescription $roleUi.shortDescription `
        -DefaultPrompt $roleUi.defaultPrompt `
        -Body $body
}

Write-Host "Built local Codex plugin at $pluginRoot"
Write-Host "Built marketplace at $marketplacePath"
