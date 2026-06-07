---
name: agents-for-star-orchestrator
description: Use when the user wants to dispatch, coordinate, review, or run Agents for Star roles locally, including CEO Strategy Agent, Product Manager Agent, Hardware Architect Agent, Firmware Agent, AI ML Agent, Backend Agent, App UX Agent, QA Reliability Agent, Supply Chain Agent, Compliance Agent, Security Agent, Finance Agent, Marketing Agent, Sales Agent, Customer Success Agent, and Knowledge Ops Agent.
---

# Agents for Star Orchestrator

## Purpose

Dispatch the local Agents for Star role system from Codex. This skill turns user requests into workflow-based Agent coordination using the repository facts in `E:\codex_dailydata_for_codex\Agents for star`.

## Repository

Default repo path:

```text
E:\codex_dailydata_for_codex\Agents for star
```

Before working, verify the path exists. If the user is already inside this repo, use the current workspace.

## Core Workflow

1. Read `docs/codex-operator-playbook.md`.
2. Select the closest workflow in `workflows/*.yaml`.
3. Run the Orchestrator prototype:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\invoke-orchestrator.ps1 -Workflow workflows\user-research-sprint.yaml -TaskId TASK-由创始人填写 -Goal "由创始人填写"
```

4. Read the returned `primary_agent` protocol from `docs/agents/roles/`.
5. Read each returned `review_agents` protocol from `docs/agents/roles/`.
6. Execute the task as a primary Agent draft plus reviewer critique.
7. If `approval_required` is true or the task is high risk, generate only a founder approval package and do not execute the action.
8. Write outputs only to `allowed_output_paths`.
9. Validate before completion:

```powershell
git diff --check
powershell -ExecutionPolicy Bypass -File scripts\validate-docs.ps1
powershell -ExecutionPolicy Bypass -File scripts\validate-schemas.ps1
powershell -ExecutionPolicy Bypass -File scripts\run-evals.ps1
```

## Workflow Selection

| User intent | Workflow |
|---|---|
| 用户研究、痛点、试点意向、主场景 | `workflows/user-research-sprint.yaml` |
| POC、设备输入、Orchestrator、审批流 | `workflows/phase-1-orchestrator-poc.yaml` |
| 模型、提示词、成本、评估 | `workflows/model-cost-eval.yaml` |

If no workflow fits, use `docs/agents/role-registry.md` to select one primary Agent and one or more reviewer Agents, then propose a new workflow YAML instead of inventing behavior.

## High-Risk Stop Rule

Never execute these actions automatically:

- payment
- contract signing
- external send
- privacy policy change
- security exception
- mass production commitment
- production secret use

For these actions, stop after producing a founder approval package.

## Output Shape

Use this structure in responses or documents:

```text
调度结果:
- Workflow:
- 主 Agent:
- 审查 Agent:
- 风险等级:
- 审批状态:
- 允许输出路径:

主 Agent 草案:
- ...

审查 Agent 意见:
- ...

创始人审批包:
- 仅 high risk 时输出

验证:
- 命令和结果
```

## Boundaries

- Do not fabricate market data, interview data, supplier quotes, regulatory fees, model pricing, or legal conclusions.
- Use “未采集”, “待验证”, or “由创始人填写” for missing facts.
- Do not use banned placeholder words.
- Prefer repository scripts over reimplementing dispatch logic.
- Keep all generated docs in Chinese unless the user asks otherwise.
