# Phase 1 POC `/goal` Prompt

用途: 当 Phase 0 工作区完成并经过创始人审批后, 用这个目标进入 POC 实现阶段。

```text
/goal 基于当前 Agents_for_star 仓库的 Phase 0 文档, 完成 Phase 1 POC 方案和最小演示实现规划: 读取 docs/product/prd-v1.md、docs/agents/role-registry.md、docs/hardware/bom-template.md、docs/security/threat-model.md、docs/compliance/privacy-impact-assessment.md 和 docs/operations/dashboard-metrics.md；选择一个主场景, 生成 POC 架构、任务路由协议、设备输入模拟方案、Founder approval flow、测试计划和 Demo 验收清单。所有输出写入 docs/phase-1-poc/。完成前运行 git diff --check, 检查无占位词, 提交并同步 GitHub。
```

## Deliverables

- `docs/phase-1-poc/architecture.md`
- `docs/phase-1-poc/task-routing-protocol.md`
- `docs/phase-1-poc/device-input-simulator.md`
- `docs/phase-1-poc/founder-approval-flow.md`
- `docs/phase-1-poc/test-plan.md`
- `docs/phase-1-poc/demo-acceptance-checklist.md`

## Verification

- 文件全部存在。
- 主场景只选择一个。
- 高风险动作必须走创始人审批。
- POC 不包含量产承诺。
- `git diff --check` 通过。
