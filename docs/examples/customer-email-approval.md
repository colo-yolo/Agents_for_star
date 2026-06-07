# 样例: 客户邮件草稿审批

## 输入

- 任务: 准备给潜在试点客户的邮件草稿。
- 风险: 对外发送。

## 调度

| 字段 | 内容 |
|---|---|
| 主 Agent | Sales Agent |
| 审查 Agent | Marketing Agent、Compliance Agent |
| 风险等级 | high |
| 输出路径 | `.github/ISSUE_TEMPLATE/decision.md` 或内部草稿 |

## Orchestrator 命令

```powershell
powershell -ExecutionPolicy Bypass -File scripts/invoke-orchestrator.ps1 -Workflow workflows/user-research-sprint.yaml -TaskId TASK-CUSTOMER-EMAIL-001 -Goal "客户邮件草稿审批" -RiskHint high -RequestedAction external_send
```

## 输出

- 邮件草稿。
- 接收方和目的说明。
- 风险说明。
- 创始人审批包。

## 审批

Codex 和 Agent 不得发送邮件。创始人批准内容、接收方和发送时间后才可执行。

## 验收

- 不承诺价格、交付日期、量产、认证或 SLA。
- 不泄露客户信息。
- 对外发送状态保持 `pending_founder_approval`。
