---
name: star-orchestrator
description: 'Use when the user invokes /star-orchestrator, 总调度, 调度 Agents for Star, 或需要选择 workflow 并协调多个本地 Principal Agent。'
---

# Star Orchestrator

## Operating Contract

This slash skill dispatches local Agents for Star role work from Codex.
Repository path: E:\codex_dailydata_for_codex\Agents for star

Required fact sources:

- AGENTS.md
- docs/codex-operator-playbook.md
- docs/agents/principal-agent-capability-standard.md
- docs/agents/role-registry.md
- docs/agents/handoff-contract.md

User-facing planning, summaries, and deliverables must be written in Chinese unless the user asks otherwise.
Do not fabricate market data, supplier quotes, certification costs, legal conclusions, model pricing, customer feedback, or private facts.
High-risk actions stop at a founder approval package. Do not execute payment, contract signing, external send, privacy policy change, security exception, production secret use, or mass production commitment.

## Verification Before Completion

Run or report why you cannot run:

- git diff --check
- powershell -ExecutionPolicy Bypass -File scripts\validate-docs.ps1
- powershell -ExecutionPolicy Bypass -File scripts\validate-agent-capabilities.ps1
- powershell -ExecutionPolicy Bypass -File scripts\validate-schemas.ps1
- powershell -ExecutionPolicy Bypass -File scripts\run-evals.ps1
- powershell -ExecutionPolicy Bypass -File scripts\verify-local-codex-agents.ps1

## Dispatch Steps

1. Match the user goal to the closest workflows/*.yaml file.
2. Run scripts/invoke-orchestrator.ps1 with Workflow, TaskId, and Goal.
3. Read the returned primary_agent and review_agents role protocols from docs/agents/roles/.
4. Produce a dispatch result, primary Agent draft, reviewer critiques, evidence paths, risk level, approval state, and verification record.
5. If no workflow fits, use docs/agents/role-registry.md to choose one primary Agent plus reviewers, then propose a new workflow instead of inventing routing behavior.

## Common Workflows

| Scenario | Workflow |
|---|---|
| User research | workflows/user-research-sprint.yaml |
| POC Orchestrator | workflows/phase-1-orchestrator-poc.yaml |
| Model cost eval | workflows/model-cost-eval.yaml |
| Hardware principal review | workflows/hardware-principal-review.yaml |
| Agent capability or local Codex dispatch review | workflows/principal-agent-review.yaml |
