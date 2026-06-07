# Founder Approval 状态机

用途: 明确哪些动作可以自动执行, 哪些动作必须创始人审批。

## 状态

```text
draft -> reviewed -> pending_founder_approval -> approved -> executed -> archived
                         |                       |
                         v                       v
                      rejected                needs_revision
```

## 状态定义

| 状态 | 含义 | 可进入条件 |
|---|---|---|
| draft | Agent 已生成草案 | low、medium、high 均可 |
| reviewed | 审查 Agent 已检查 | medium、high 必须经过 |
| pending_founder_approval | 等待创始人审批 | 所有 high 动作必须经过 |
| approved | 创始人同意 | 审批记录存在 |
| rejected | 创始人拒绝 | 拒绝理由写入审计 |
| needs_revision | 需要修改 | 修改要求写入任务 |
| executed | 动作已执行 | 只允许 approved 后执行 high 动作 |
| archived | 证据归档 | 输出写入事实源 |

## 强制审批动作

- 付款、下单、签约、招聘、融资。
- 对外发送邮件、报价、承诺、营销发布。
- 隐私策略、安全策略、合规结论。
- 量产承诺、客户交付承诺。
- 删除或覆盖关键事实源。

## 审批记录字段

| 字段 | 说明 |
|---|---|
| approval_id | 审批编号 |
| task_id | 关联任务 |
| requested_by | 请求 Agent |
| reviewed_by | 审查 Agent |
| decision | approved、rejected、needs_revision |
| founder_note | 创始人说明 |
| timestamp | 时间 |

