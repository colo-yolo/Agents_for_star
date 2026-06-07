# 审计日志目录规范

## 目的

记录 Codex Agents 调度、handoff、审批、评估和归档的证据链。每次 workflow 执行都应能追溯到任务输入、主 Agent、审查 Agent、风险等级、审批状态和输出路径。

## 目录结构

```text
docs/audit/
  README.md
  examples/
    handoff-package-example.yaml
    approval-package-example.yaml
    audit-log-example.md
```

## 日志命名

正式落盘时建议使用:

```text
docs/audit/YYYY-MM-DD/TASK-编号.md
```

示例:

```text
docs/audit/2026-06-08/TASK-20260608-001.md
```

## 必填字段

| 字段 | 说明 |
|---|---|
| task_id | 任务编号 |
| workflow_id | workflow YAML 编号 |
| primary_agent | 主 Agent |
| review_agents | 审查 Agent |
| risk_level | low、medium、high |
| approval_state | draft、reviewed、pending_founder_approval、approved、rejected、archived |
| context_paths | 读取的事实源 |
| output_paths | 写入或建议写入的事实源 |
| evidence_paths | 支撑结论的证据路径 |
| forbidden_actions_checked | 是否检查禁止动作 |
| founder_decision | 创始人决策, 如未审批则为 pending_founder_approval |

## 落盘规则

1. low risk 可记录草案和输出路径。
2. medium risk 必须记录审查 Agent 结论。
3. high risk 必须记录审批包, 不得记录为已执行。
4. 如果事实未采集, 必须写为未采集。
5. 如果外部事实未验证, 必须写为待验证。

## 高风险边界

审计日志只能记录和归档, 不允许实际执行付款、签约、对外发送、隐私策略、安全例外或量产承诺。
