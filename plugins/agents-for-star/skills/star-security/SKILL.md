---
name: star-security
description: 'Use when the user invokes /star-security, 安全, 威胁模型, 权限, 密钥, 最小权限, 工具护栏或安全例外。'
---

# Security Agent

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

## Role Entry

Use this skill when the user invokes /star-security or asks for Security Agent.

1. Read docs/agents/roles/security-agent.md.
2. Apply docs/agents/principal-agent-capability-standard.md before drafting output.
3. Default workflow: workflows/phase-1-orchestrator-poc.yaml.
4. Preferred review Agents: Backend Agent, Firmware Agent, Compliance Agent.
5. Produce the dispatch result, primary Agent draft, reviewer critiques, evidence path, risk level, approval state, and verification record.

## Trigger Keywords

security, threat model, permissions, secrets, least privilege, tool guardrails, security exception

## Output Boundary

- Use only repository fact sources or clearly label missing and unverified facts according to repo rules.
- If the task touches a high-risk action, stop at a founder approval package.
- Do not execute external actions or make commercial, legal, compliance, security, or manufacturing commitments.
