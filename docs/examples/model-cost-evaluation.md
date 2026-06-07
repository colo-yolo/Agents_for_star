# 样例: 模型成本评估

## 输入

- Workflow: `workflows/model-cost-eval.yaml`
- 任务: 比较模型策略、成本假设和敏感数据处理风险。

## 调度

| 字段 | 内容 |
|---|---|
| 主 Agent | AI ML Agent |
| 审查 Agent | Security Agent、Finance Agent |
| 风险等级 | medium |
| 输出路径 | `docs/evaluation/model-cost-quality-tracker.md` |

## 命令

```powershell
powershell -ExecutionPolicy Bypass -File scripts/invoke-orchestrator.ps1 -Workflow workflows/model-cost-eval.yaml -TaskId TASK-MODEL-COST-001 -Goal "模型成本评估"
```

## 输出

- 模型候选字段。
- 成本质量记录字段。
- 待验证价格来源。
- 敏感数据处理风险。

## 审批

付费 API、云资源、外部模型处理敏感数据都需要创始人审批。

## 验收

- 不编造模型价格、延迟、benchmark 或 API 费用。
- 未验证价格写为待验证。
- Finance Agent 检查预算影响。
- Security Agent 检查敏感数据外发风险。
