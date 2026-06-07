# Agents for Star

这是一个面向智能 AI 硬件产品的一人公司, One Person Company, OPC 多角色 Agent 规划仓库。它把产品战略、Agent 智能分工、硬件到软件的开发路线、以及可直接交给 Codex `/goal` 的目标 prompt 放在同一个 GitHub 源码仓库中。

## 仓库目标

本仓库的第一阶段目标不是立即写硬件固件或量产代码, 而是先把一个可执行的智能硬件 OPC 操作系统定义清楚:

- 明确智能 AI 硬件产品的参考定位和可替换边界。
- 定义多角色 Agents 的职责、智能能力、输入输出、工具权限和验收指标。
- 给出从概念验证到量产导入的开发规划。
- 提供一个适合 Codex `/goal` 长任务模式使用的中文目标 prompt。
- 让 GitHub 成为后续产品、技术、运营和 Agent 协作的单一事实源。

## 主要文档

| 文件 | 用途 |
|---|---|
| [docs/agent-intelligence-and-development-plan.md](docs/agent-intelligence-and-development-plan.md) | 智能硬件 OPC Agent 架构与开发路线图 |
| [docs/codex-goal-prompt.md](docs/codex-goal-prompt.md) | 可直接复制给 Codex `/goal` 的输入 prompt 和完整任务书 |
| [docs/strategy/okr.md](docs/strategy/okr.md) | Phase 0 OKR |
| [docs/product/prd-v1.md](docs/product/prd-v1.md) | PRD v1 |
| [docs/agents/role-registry.md](docs/agents/role-registry.md) | Agent 角色注册表 |
| [docs/security/threat-model.md](docs/security/threat-model.md) | 威胁模型初稿 |
| [docs/compliance/privacy-impact-assessment.md](docs/compliance/privacy-impact-assessment.md) | 隐私影响分析初稿 |
| [docs/operations/dashboard-metrics.md](docs/operations/dashboard-metrics.md) | OPC 经营指标表 |
| [docs/codex-goals/phase-1-poc-goal.md](docs/codex-goals/phase-1-poc-goal.md) | 下一阶段 POC `/goal` |
| [docs/superpowers/specs/2026-06-07-opc-ai-hardware-agents-design.md](docs/superpowers/specs/2026-06-07-opc-ai-hardware-agents-design.md) | 当前阶段设计规格 |
| [docs/superpowers/plans/2026-06-07-opc-ai-hardware-agents-development-plan.md](docs/superpowers/plans/2026-06-07-opc-ai-hardware-agents-development-plan.md) | 后续执行计划 |
| [AGENTS.md](AGENTS.md) | Codex 在本仓库工作的长期规则 |

## 推荐使用方式

在 Codex CLI 中打开本仓库后, 使用短目标指向仓库内的详细任务书:

```text
/goal 请在当前仓库继续推进 Agents for Star: 以 docs/codex-goal-prompt.md 作为任务书, 完成智能 AI 硬件 OPC 多角色 Agent 规划仓库的后续建设、校验、提交和同步。完成前必须逐项核对任务书中的 Deliverables、Requirements、Verification 和 Stop Conditions。
```

建议把长任务说明放进文件, 再让 `/goal` 指向该文件。这样后续 Codex 会话可以从仓库事实源读取完整上下文, 不依赖一次性聊天记录。

## 当前阶段的核心假设

- 参考产品暂定为“桌面/随身 AI 工作助理硬件”: 麦克风、摄像头或低功耗视觉传感器、小屏幕或指示灯、边缘唤醒、云端推理与 Agent 协作。
- 最终硬件形态可以替换为桌面设备、胸牌、会议终端、智能音箱、开发板套件或工业场景设备。
- 创始人只有一个人, 所以 Agents 不只是聊天角色, 而是覆盖产品、研发、供应链、合规、销售和运营的工作流系统。
- 所有人类不可外包的责任由创始人最终审批: 资金支出、供应商签约、法律合规、上市承诺、隐私策略和安全例外。
