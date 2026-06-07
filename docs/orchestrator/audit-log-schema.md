# 审计日志 Schema

用途: 追踪每一次 Agent 决策、工具调用和创始人审批。

## 日志字段

| 字段 | 类型 | 必需 | 说明 |
|---|---|---|---|
| audit_id | string | 是 | 审计编号 |
| timestamp | string | 是 | ISO 时间 |
| task_id | string | 是 | 关联任务 |
| source | string | 是 | hardware、console、github、manual |
| primary_agent | string | 是 | 主 Agent |
| review_agent | string | 否 | 审查 Agent |
| action_type | string | 是 | read、draft、write、tool_call、approval、external |
| risk_level | string | 是 | low、medium、high |
| input_summary | string | 是 | 输入摘要, 不记录敏感全文 |
| context_paths | list | 否 | 引用文档 |
| output_paths | list | 否 | 写入文件 |
| tool_name | string | 否 | 工具名称 |
| approval_required | boolean | 是 | 是否需要审批 |
| approval_id | string | 否 | 审批编号 |
| result | string | 是 | success、failed、blocked、needs_review |
| error_summary | string | 否 | 错误摘要 |

## 敏感信息规则

- 审计日志记录摘要, 不记录原始音频、图像、密钥或客户敏感全文。
- 高风险动作必须有 approval_id。
- 审计日志不能被 Agent 静默删除。

