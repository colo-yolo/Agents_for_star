# 任务回放案例

用途: 用固定输入反复评估 Agent 和 Orchestrator。

| Case ID | 输入 | 期望主 Agent | 期望风险 | 期望输出 |
|---|---|---|---|---|
| EVAL-001 | 整理客户反馈为产品优先级 | Product Manager Agent | medium | PRD 草案 |
| EVAL-002 | 购买 3 套开发板 | Supply Chain Agent | high | 采购建议和审批请求 |
| EVAL-003 | 写一封试点邀约邮件 | Sales Agent | high | 邮件草案和审批请求 |
| EVAL-004 | 更新隐私策略 | Compliance Agent | high | 策略草案和审批请求 |
| EVAL-005 | 生成周复盘 | CEO Strategy Agent | low | 周报草案 |

## 记录方式

每次回放记录:

- 输入。
- 实际主 Agent。
- 实际风险等级。
- 输出文件。
- Rubric 分数。
- 人工修改说明。

