# 样例: POC Demo

## 输入

- Workflow: `workflows/phase-1-orchestrator-poc.yaml`
- 任务: 用设备输入模拟器打通任务路由、Agent 输出、风险判断和审批状态。

## 调度

| 字段 | 内容 |
|---|---|
| 主 Agent | Backend Agent |
| 审查 Agent | Security Agent、QA Reliability Agent |
| 风险等级 | high |
| 输出路径 | `docs/phase-1-poc/` |

## 命令

```powershell
powershell -ExecutionPolicy Bypass -File scripts/invoke-orchestrator.ps1 -Workflow workflows/phase-1-orchestrator-poc.yaml -TaskId TASK-POC-001 -Goal "Phase 1 POC Demo"
```

## 输出

- 设备事件契约草案。
- 路由决策草案。
- 创始人审批包。
- Demo 和验收清单更新建议。

## 审批

该 workflow 默认 high risk。任何对外发送、生产密钥、付款或安全例外都必须停在审批包。

## 验收

- 审计日志包含 task_id、Agent、risk_level、approval_state 和 evidence_paths。
- 不连接真实外部系统。
- QA Reliability Agent 形成回放测试要求。
