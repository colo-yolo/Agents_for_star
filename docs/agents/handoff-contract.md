# Agent Handoff 合约

## 目的

定义 Codex 调度多个 Agent 时的标准交接格式。该合约借鉴 handoff、guardrail、trace 和 workflow 配置思想, 但当前阶段只作为仓库内的执行规范。

## 适用范围

- 主 Agent 向审查 Agent 交接。
- 审查 Agent 向创始人审批交接。
- Agent 向 Knowledge Ops Agent 归档交接。
- Codex 根据 `workflows/*.yaml` 执行文档任务。

## Handoff 输入包

| 字段 | 说明 | 必填 |
|---|---|---|
| `task_id` | 任务编号 | 是 |
| `workflow_id` | workflow 配置编号 | 是 |
| `from_agent` | 发起 Agent | 是 |
| `to_agent` | 接收 Agent | 是 |
| `risk_level` | low、medium、high | 是 |
| `approval_state` | draft、reviewed、pending_founder_approval 等 | 是 |
| `goal` | 期望结果 | 是 |
| `context_paths` | 事实源路径列表 | 是 |
| `output_paths` | 目标输出路径列表 | 是 |
| `known_facts` | 已确认事实 | 是 |
| `unknowns` | 未采集或待验证事项 | 是 |
| `forbidden_actions` | 禁止动作 | 是 |
| `review_questions` | 需要接收方判断的问题 | 否 |

## Handoff 输出包

| 字段 | 说明 |
|---|---|
| `summary` | 交接结论摘要 |
| `changes_made` | 已修改或建议修改的文件 |
| `risk_assessment` | 风险等级和原因 |
| `approval_required` | 是否需要创始人审批 |
| `founder_approval_package` | 高风险任务审批包 |
| `evidence_paths` | 证据路径 |
| `next_agent` | 下一接收 Agent |
| `next_action` | 下一步动作 |

## 禁止动作

无论任何 workflow 如何配置, 以下动作只能生成审批包, 不得自动执行:

- 付款、下单、订阅和转账。
- 签署合同、NDA、试点协议或采购条款。
- 对外发送邮件、报价、发布材料或客户承诺。
- 修改隐私策略、安全策略、合规结论。
- 关闭安全检查、使用生产密钥或批准安全例外。
- 承诺 EVT、DVT、PVT、Launch、认证、产能或量产。

## 审批包格式

```yaml
approval_package:
  task_id: TASK-由创始人填写
  requested_by: Agent 名称
  reviewed_by: Agent 名称
  risk_level: high
  requested_action: 由创始人填写
  evidence_paths:
    - docs/路径
  impact:
    product: 待验证
    finance: 待验证
    security: 待验证
    compliance: 待验证
    customer: 待验证
  rollback_plan: 待验证
  founder_decision: pending_founder_approval
```

## Codex 调度步骤

1. 读取相关 workflow YAML。
2. 读取 `docs/agents/role-registry.md`。
3. 读取主 Agent 和审查 Agent 的独立协议。
4. 生成 Handoff 输入包。
5. 主 Agent 输出草案。
6. 审查 Agent 输出风险、缺口和验收意见。
7. 如有高风险动作, 生成审批包并停止执行。
8. Knowledge Ops Agent 归档证据路径和下一步 `/goal`。

## 失败处理

| 失败类型 | 处理方式 |
|---|---|
| 事实源缺失 | 标注未采集, 不补写事实 |
| 风险等级不清 | 默认提升到 high |
| 审查 Agent 与主 Agent 冲突 | 生成决策记录草案, 等待创始人裁决 |
| 输出路径不清 | 交给 Knowledge Ops Agent 归档建议 |
| 外部事实过期 | 标注待验证, 不写成当前事实 |

## 质量指标

- 每次 handoff 是否包含 `task_id`、Agent、风险、证据路径。
- high risk 是否全部进入 `pending_founder_approval`。
- 审查 Agent 是否明确指出缺口和验收标准。
- 输出是否写入指定事实源。
