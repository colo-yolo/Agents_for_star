---
name: star-ai-ml
description: 'Use when the user invokes /star-ai-ml, AI, 模型策略, 提示词, eval, 模型成本, 输出质量或敏感数据处理。'
---

# AI ML Agent

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

Use this skill when the user invokes /star-ai-ml or asks for AI ML Agent.

1. Read docs/agents/roles/ai-ml-agent.md.
2. Apply docs/agents/principal-agent-capability-standard.md before drafting output.
3. Default workflow: workflows/model-cost-eval.yaml.
4. Preferred review Agents: Security Agent, Finance Agent, Product Manager Agent.
5. Produce the dispatch result, primary Agent draft, reviewer critiques, evidence path, risk level, approval state, and verification record.

## Trigger Keywords

model strategy, prompt, eval, model cost, AI output quality, human escalation, sensitive data

## Output Boundary

- Use only repository fact sources or clearly label missing and unverified facts according to repo rules.
- If the task touches a high-risk action, stop at a founder approval package.
- Do not execute external actions or make commercial, legal, compliance, security, or manufacturing commitments.
