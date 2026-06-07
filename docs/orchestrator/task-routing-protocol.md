# Orchestrator 任务路由协议

用途: 将创始人的目标、硬件输入或文档变更路由给合适的主 Agent、审查 Agent 和审批流程。

## 输入格式

| 字段 | 说明 | 示例 |
|---|---|---|
| task_id | 任务编号 | TASK-2026-001 |
| source | 来源 | hardware_voice、console、github_doc、manual |
| goal | 期望结果 | 将客户反馈整理成产品优先级 |
| context_paths | 相关文档路径 | `docs/product/prd-v1.md` |
| risk_hint | 创始人提示的风险 | low、medium、high |
| requested_output | 交付物类型 | doc、issue_draft、decision、test_plan |

## 路由规则

| 任务类型 | 主 Agent | 审查 Agent | 风险默认值 |
|---|---|---|---|
| 战略和 OKR | CEO Strategy Agent | Finance Agent | medium |
| PRD 和用户故事 | Product Manager Agent | QA Reliability Agent | medium |
| 硬件和 BOM | Hardware Architect Agent | Supply Chain Agent | medium |
| 固件和 OTA | Firmware Agent | Security Agent | high |
| 模型和提示词 | AI ML Agent | Security Agent | medium |
| 后端和权限 | Backend Agent | Security Agent | high |
| 控制台和审批体验 | App UX Agent | Compliance Agent | medium |
| 测试和发布 | QA Reliability Agent | Product Manager Agent | medium |
| 供应商和采购 | Supply Chain Agent | Finance Agent | high |
| 隐私和合规 | Compliance Agent | Security Agent | high |
| 财务和预算 | Finance Agent | CEO Strategy Agent | high |
| 市场内容 | Marketing Agent | Product Manager Agent | high |
| 销售跟进 | Sales Agent | Marketing Agent | high |
| 客户反馈 | Customer Success Agent | Product Manager Agent | medium |
| 文档归档 | Knowledge Ops Agent | CEO Strategy Agent | low |

## 风险等级

| 等级 | 定义 | 自动执行 |
|---|---|---|
| low | 内部草案、读取文档、整理信息 | 可以, 需审计 |
| medium | 更新路线图、创建任务草案、影响内部优先级 | 可以生成草案, 需审查 |
| high | 付款、签约、对外发送、隐私、安全、合规、量产承诺 | 不允许自动执行 |

## 输出格式

| 字段 | 说明 |
|---|---|
| assigned_primary_agent | 主 Agent |
| assigned_review_agent | 审查 Agent |
| risk_level | low、medium、high |
| approval_required | true 或 false |
| output_path | 目标文件或 issue 草案路径 |
| audit_log_required | true |

