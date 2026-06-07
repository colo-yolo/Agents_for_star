# Workflow 配置规范

## 目的

定义 `workflows/*.yaml` 的字段, 让 Codex 或后续 Orchestrator 能按版本化配置调度 Agent。本文借鉴 YAML 化工作流和状态图思想, 但当前只作为配置规范。

## 顶层字段

| 字段 | 说明 | 必填 |
|---|---|---|
| `workflow_id` | 唯一编号 | 是 |
| `name` | 中文名称 | 是 |
| `description` | 用途说明 | 是 |
| `risk_default` | low、medium、high | 是 |
| `trigger` | 触发来源 | 是 |
| `agents` | 主 Agent、审查 Agent、归档 Agent | 是 |
| `context_paths` | 需要读取的事实源 | 是 |
| `output_paths` | 允许写入的目标路径 | 是 |
| `steps` | 执行步骤 | 是 |
| `guardrails` | 禁止和审批规则 | 是 |
| `evaluation` | 回放和验收配置 | 否 |

## Agent 字段

```yaml
agents:
  primary: Product Manager Agent
  reviewers:
    - QA Reliability Agent
  archive: Knowledge Ops Agent
```

## Step 字段

| 字段 | 说明 |
|---|---|
| `id` | 步骤编号 |
| `agent` | 执行 Agent |
| `action` | 动作 |
| `inputs` | 输入路径或上一步输出 |
| `outputs` | 输出路径 |
| `approval_state` | draft、reviewed、pending_founder_approval 等 |

## Guardrail 字段

```yaml
guardrails:
  forbidden_actions:
    - payment
    - contract_signing
    - external_send
    - privacy_policy_change
    - security_exception
    - mass_production_commitment
  high_risk_policy: founder_approval_required
  unknown_fact_policy: mark_as_uncollected_or_pending_verification
```

## Codex 解释规则

1. Codex 必须先读取 workflow, 再读取对应 Agent 协议。
2. Codex 只能写入 `output_paths` 声明的路径。
3. 如果任务需要写入其他路径, 必须先说明原因。
4. 如果 workflow 和 Agent 协议冲突, 以更严格的审批规则为准。
5. 如果出现 high risk 动作, Codex 必须停止执行动作, 只输出审批包。

## 验证规则

- 每个 workflow 必须至少包含一个 primary Agent。
- 每个 medium 或 high workflow 必须至少包含一个 reviewer。
- 每个 workflow 必须包含 guardrails。
- 每个 workflow 必须引用至少一个 context path。
- 每个 workflow 的 high risk policy 必须保留创始人审批。
