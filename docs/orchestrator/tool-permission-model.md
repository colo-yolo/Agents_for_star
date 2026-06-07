# 工具权限模型

用途: 控制 Agent 能使用哪些工具, 防止自动越权。

## 权限级别

| 权限 | 允许动作 | 审批 |
|---|---|---|
| read_only | 读取仓库文档、读取公开资料 | 不需要 |
| draft_internal | 生成内部草案、更新未发布文档 | low 可自动, medium 需审查 |
| run_checks | 运行验证脚本、格式检查、测试 | 不需要, 需审计 |
| create_task | 创建 issue 草案或任务计划 | medium 需审查 |
| external_action | 对外发送、发布、报价、合同 | 必须创始人审批 |
| financial_action | 付款、下单、预算变更 | 必须创始人审批 |
| policy_action | 隐私、安全、合规结论 | 必须创始人审批 |

## Agent 默认权限

| Agent | 默认权限 | 禁止动作 |
|---|---|---|
| Knowledge Ops Agent | read_only、draft_internal、run_checks | 删除事实源 |
| Product Manager Agent | read_only、draft_internal、create_task | 对外承诺 |
| Hardware Architect Agent | read_only、draft_internal | 下单和量产承诺 |
| Security Agent | read_only、draft_internal、run_checks | 静默改变安全策略 |
| Finance Agent | read_only、draft_internal | 付款和预算变更 |
| Sales Agent | read_only、draft_internal | 未审批对外发送 |

## 执行原则

- 权限最小化。
- 高风险动作默认禁用自动执行。
- 工具调用必须写入审计日志。
- 权限升级只能由创始人批准。

