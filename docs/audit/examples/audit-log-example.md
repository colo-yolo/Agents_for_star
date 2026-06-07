# 审计日志示例

| 字段 | 内容 |
|---|---|
| task_id | TASK-EXAMPLE-003 |
| workflow_id | phase_1_orchestrator_poc |
| primary_agent | Backend Agent |
| review_agents | Security Agent, QA Reliability Agent |
| risk_level | high |
| approval_state | pending_founder_approval |
| context_paths | `docs/orchestrator/task-routing-protocol.md`, `docs/phase-1-poc/architecture.md` |
| output_paths | `docs/phase-1-poc/founder-approval-flow.md` |
| evidence_paths | `docs/orchestrator/tool-permission-model.md` |
| forbidden_actions_checked | payment, contract_signing, external_send, privacy_policy_change, security_exception, mass_production_commitment |
| founder_decision | pending_founder_approval |

## 结论

该任务涉及 high risk 路径, 只能生成创始人审批包, 不执行任何对外发送、付款、签约、隐私策略、安全例外或量产承诺动作。
