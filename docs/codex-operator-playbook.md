# Codex 调度手册

## 目的

指导创始人在 Codex 中调度本仓库的多 Agent 系统。当前推荐模式是 Codex 读取 workflow YAML 和角色协议, 再用脚本生成调度包、审批包和审计日志草案。

## 基本流程

1. 选择一个 workflow, 例如 `workflows/user-research-sprint.yaml`。
2. 让 Codex 读取 `docs/agents/handoff-contract.md`。
3. 让 Codex 读取 `docs/agents/principal-agent-capability-standard.md`。
4. 让 Codex 读取 workflow 中声明的主 Agent 和审查 Agent 角色协议。
5. 运行 Orchestrator 原型生成调度包。
6. 主 Agent 输出草案。
7. 审查 Agent 检查风险、事实缺口和验收标准。
8. high risk 任务停止在创始人审批包。
9. 运行校验并提交。

## 标准 `/goal` 模板

```text
/goal
Objective: 按指定 workflow 调度 Codex Agents 完成任务, 输出事实源更新、审查结论和必要的创始人审批包。

Context:
- Workflow: workflows/由创始人填写.yaml
- Handoff: docs/agents/handoff-contract.md
- Role registry: docs/agents/role-registry.md
- Principal standard: docs/agents/principal-agent-capability-standard.md

Requirements:
- 先运行 `powershell -ExecutionPolicy Bypass -File scripts/invoke-orchestrator.ps1 -Workflow workflows/由创始人填写.yaml -TaskId TASK-由创始人填写 -Goal "由创始人填写"`。
- 按输出的 primary_agent 和 review_agents 读取对应 `docs/agents/roles/*.md`。
- 只写入 workflow 声明的 allowed output paths。
- 高风险动作只生成 founder approval package, 不执行。
- 未采集事实写为“未采集”, 未验证事实写为“待验证”。

Verification:
- 运行 `git diff --check`。
- 运行 `powershell -ExecutionPolicy Bypass -File scripts/validate-docs.ps1`。
- 运行 `powershell -ExecutionPolicy Bypass -File scripts/validate-agent-capabilities.ps1`。
- 运行 `powershell -ExecutionPolicy Bypass -File scripts/validate-schemas.ps1`。
- 运行 `powershell -ExecutionPolicy Bypass -File scripts/run-evals.ps1`。

Stop Conditions:
- 输出写入事实源。
- 审查 Agent 结论存在。
- 如涉及 high risk, 审批包存在且动作未执行。
- 本地提交并同步 GitHub。
```

## Orchestrator 命令

### 用户研究冲刺

```powershell
powershell -ExecutionPolicy Bypass -File scripts/invoke-orchestrator.ps1 `
  -Workflow workflows/user-research-sprint.yaml `
  -TaskId TASK-USER-RESEARCH-001 `
  -Goal "整理用户研究并更新主场景决策"
```

### 高风险对外发送

```powershell
powershell -ExecutionPolicy Bypass -File scripts/invoke-orchestrator.ps1 `
  -Workflow workflows/user-research-sprint.yaml `
  -TaskId TASK-EXTERNAL-001 `
  -Goal "准备向试点客户发送访谈邀请" `
  -RiskHint high `
  -RequestedAction external_send
```

该命令必须输出 `approval_required: true` 和 `founder_approval_package`。

## Agent 调度规则

| 场景 | Workflow | 主 Agent | 审查 Agent |
|---|---|---|---|
| 用户研究 | `workflows/user-research-sprint.yaml` | Product Manager Agent | Customer Success Agent、Compliance Agent |
| POC Orchestrator | `workflows/phase-1-orchestrator-poc.yaml` | Backend Agent | Security Agent、QA Reliability Agent |
| 模型成本评估 | `workflows/model-cost-eval.yaml` | AI ML Agent | Security Agent、Finance Agent |
| 硬件架构评审 | `workflows/hardware-principal-review.yaml` | Hardware Architect Agent | Supply Chain Agent、Security Agent、Firmware Agent、QA Reliability Agent、Finance Agent |
| Agent 能力复审和本地 Codex 配置 | `workflows/principal-agent-review.yaml` | Knowledge Ops Agent | CEO Strategy Agent、Product Manager Agent、Security Agent、QA Reliability Agent、Compliance Agent、Finance Agent |

### Principal 硬件架构评审

```powershell
powershell -ExecutionPolicy Bypass -File scripts/invoke-orchestrator.ps1 `
  -Workflow workflows/hardware-principal-review.yaml `
  -TaskId TASK-HW-REVIEW-001 `
  -Goal "Principal 硬件架构评审"
```

硬件任务必须读取:

- `docs/agents/roles/hardware-architect-agent.md`
- `docs/hardware/hardware-principal-playbook.md`
- `docs/hardware/hardware-design-review-checklist.md`
- `docs/hardware/hardware-bringup-evt-plan.md`
- `docs/hardware/hardware-fmea-template.md`

### Principal Agent 能力复审

```powershell
powershell -ExecutionPolicy Bypass -File scripts/invoke-orchestrator.ps1 `
  -Workflow workflows/principal-agent-review.yaml `
  -TaskId TASK-PRINCIPAL-AGENT-REVIEW-001 `
  -Goal "复审 16 个 Agent 协议、本地 Codex Skill、workflow、eval 和审批边界"
```

Agent 系统复审必须读取:

- `docs/agents/principal-agent-capability-standard.md`
- `docs/agents/role-registry.md`
- `codex-skills/agents-for-star-orchestrator/SKILL.md`
- `scripts/validate-agent-capabilities.ps1`
- `scripts/verify-local-codex-agents.ps1`

## 停止条件

遇到以下情况, Codex 必须停止执行动作, 只输出审批包:

- 付款、下单、订阅或转账。
- 签署合同、NDA、试点协议或采购条款。
- 对外发送邮件、报价、发布材料或客户承诺。
- 修改隐私策略、安全策略或合规结论。
- 使用生产密钥、关闭安全检查或批准安全例外。
- 承诺 EVT、DVT、PVT、Launch、认证、产能或量产。

## 每次结束前检查

```powershell
git diff --check
powershell -ExecutionPolicy Bypass -File scripts/validate-docs.ps1
powershell -ExecutionPolicy Bypass -File scripts/validate-agent-capabilities.ps1
powershell -ExecutionPolicy Bypass -File scripts/validate-schemas.ps1
powershell -ExecutionPolicy Bypass -File scripts/run-evals.ps1
powershell -ExecutionPolicy Bypass -File scripts/verify-local-codex-agents.ps1
git status --short --branch
```
