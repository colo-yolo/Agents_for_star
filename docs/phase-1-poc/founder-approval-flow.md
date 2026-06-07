# Founder Approval Flow

用途: POC 中演示创始人如何审查和批准高风险动作。

## 审批触发

以下动作必须进入审批:

- 对外发送。
- 付款、下单、签约。
- 隐私、安全、合规策略变更。
- 量产或客户交付承诺。
- 删除事实源。

## 审批界面 POC

早期不要求完整前端, 可以使用 Markdown 审批记录:

| 字段 | 内容 |
|---|---|
| approval_id | 由系统生成 |
| task_id | 关联任务 |
| risk_level | high |
| requested_action | Agent 请求动作 |
| recommendation | Agent 建议 |
| founder_decision | approved、rejected、needs_revision |
| founder_note | 由创始人填写 |

## 验收

- 未审批 high 动作不能进入 executed。
- 审批结果写入审计日志。
- 被拒绝动作必须保留拒绝理由。

