# 样例: 用户研究冲刺

## 输入

- Workflow: `workflows/user-research-sprint.yaml`
- 任务: 整理真实访谈材料, 更新痛点评分和主场景决策。
- 当前事实: 真实访谈记录未采集。

## 调度

| 字段 | 内容 |
|---|---|
| 主 Agent | Product Manager Agent |
| 审查 Agent | Customer Success Agent、Compliance Agent |
| 风险等级 | medium |
| 输出路径 | `docs/research/pain-scorecard.md`, `docs/research/main-scenario-decision.md` |

## 命令

```powershell
powershell -ExecutionPolicy Bypass -File scripts/invoke-orchestrator.ps1 -Workflow workflows/user-research-sprint.yaml -TaskId TASK-USER-RESEARCH-001 -Goal "用户研究冲刺"
```

## 输出

- 更新痛点评分规则。
- 标注未采集访谈。
- 形成下一轮访谈问题。

## 审批

如果需要联系真实用户或发送访谈邀请, 风险升为 high, 进入创始人审批。

## 验收

- 没有虚构用户、公司、预算或访谈结论。
- 所有缺失数据写为未采集。
- Compliance Agent 检查敏感数据采集风险。
