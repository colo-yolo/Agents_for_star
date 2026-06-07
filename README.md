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
| [docs/agents/roles/](docs/agents/roles/) | 16 个核心 Agent 独立角色协议 |
| [docs/agents/handoff-contract.md](docs/agents/handoff-contract.md) | Agent 之间的标准交接合约 |
| [docs/research/](docs/research/) | 用户研究、痛点评分、硬件验收和试点意向模板 |
| [docs/orchestrator/](docs/orchestrator/) | Agent 任务路由、审批状态机、审计日志、工具权限和记忆策略 |
| [docs/orchestrator/workflow-spec.md](docs/orchestrator/workflow-spec.md) | Workflow YAML 配置规范 |
| [docs/orchestrator/runtime-options.md](docs/orchestrator/runtime-options.md) | Agent 运行时选型建议 |
| [docs/phase-1-poc/](docs/phase-1-poc/) | Phase 1 POC 架构、设备输入模拟器、Demo 脚本、测试计划和验收清单 |
| [docs/evaluation/](docs/evaluation/) | Agent 输出评分、任务回放、失败分类和成本质量记录 |
| [docs/evaluation/eval-ci-gate.md](docs/evaluation/eval-ci-gate.md) | Agent Eval CI Gate 规则 |
| [docs/references/open-source-agent-patterns.md](docs/references/open-source-agent-patterns.md) | 开源 Agent 项目借鉴分析 |
| [docs/audit/](docs/audit/) | Agent 调度审计日志落盘规范和示例 |
| [workflows/](workflows/) | Codex 可读取的 Agent workflow YAML 样例 |
| [evals/](evals/) | Agent 路由、审批和输出质量评估样例 |
| [schemas/](schemas/) | Workflow、Eval、handoff package、approval package 的 schema |
| [docs/security/threat-model.md](docs/security/threat-model.md) | 威胁模型初稿 |
| [docs/security/access-control-matrix.md](docs/security/access-control-matrix.md) | 访问控制矩阵产品设计初稿 |
| [docs/compliance/privacy-impact-assessment.md](docs/compliance/privacy-impact-assessment.md) | 隐私影响分析初稿 |
| [docs/compliance/data-retention-policy-draft.md](docs/compliance/data-retention-policy-draft.md) | 数据保留政策产品设计初稿 |
| [docs/compliance/founder-approval-policy.md](docs/compliance/founder-approval-policy.md) | 创始人审批政策产品设计初稿 |
| [docs/operations/dashboard-metrics.md](docs/operations/dashboard-metrics.md) | OPC 经营指标表 |
| [docs/operations/weekly-review-template.md](docs/operations/weekly-review-template.md) | 每周经营复盘模板 |
| [docs/operations/decision-dashboard.md](docs/operations/decision-dashboard.md) | 关键决策和审批状态仪表盘 |
| [docs/finance/cashflow-scenario-template.md](docs/finance/cashflow-scenario-template.md) | 现金流情景模板 |
| [docs/codex-goals/phase-1-poc-goal.md](docs/codex-goals/phase-1-poc-goal.md) | 下一阶段 POC `/goal` |
| [docs/codex-goals/master-roadmap.md](docs/codex-goals/master-roadmap.md) | 后续 6 个可复制 `/goal` 总路线 |
| [docs/codex-operator-playbook.md](docs/codex-operator-playbook.md) | Codex 调度多 Agent 的操作手册 |
| [docs/local-codex-agent-setup.md](docs/local-codex-agent-setup.md) | 本地 Codex Skill 安装和验证说明 |
| [docs/examples/](docs/examples/) | 用户研究、POC、BOM、客户邮件、模型成本和隐私策略样例 |
| [codex-skills/agents-for-star-orchestrator/](codex-skills/agents-for-star-orchestrator/) | 可安装到本机 Codex 的 Agents for Star 调度 Skill |
| [.github/ISSUE_TEMPLATE/](.github/ISSUE_TEMPLATE/) | GitHub bug、feature、research、risk、decision 协作模板 |
| [.github/pull_request_template.md](.github/pull_request_template.md) | Pull Request 检查模板 |
| [scripts/validate-docs.ps1](scripts/validate-docs.ps1) | 文档完整性、占位词、乱码和 Markdown 空白校验脚本 |
| [docs/superpowers/specs/2026-06-07-opc-ai-hardware-agents-design.md](docs/superpowers/specs/2026-06-07-opc-ai-hardware-agents-design.md) | 当前阶段设计规格 |
| [docs/superpowers/plans/2026-06-07-opc-ai-hardware-agents-development-plan.md](docs/superpowers/plans/2026-06-07-opc-ai-hardware-agents-development-plan.md) | 后续执行计划 |
| [AGENTS.md](AGENTS.md) | Codex 在本仓库工作的长期规则 |

## 推荐使用方式

在 Codex CLI 中打开本仓库后, 使用短目标指向仓库内的详细任务书:

```text
/goal 请在当前仓库继续推进 Agents for Star: 以 docs/codex-goal-prompt.md 作为任务书, 完成智能 AI 硬件 OPC 多角色 Agent 规划仓库的后续建设、校验、提交和同步。完成前必须逐项核对任务书中的 Deliverables、Requirements、Verification 和 Stop Conditions。
```

建议把长任务说明放进文件, 再让 `/goal` 指向该文件。这样后续 Codex 会话可以从仓库事实源读取完整上下文, 不依赖一次性聊天记录。

## 后续开发路线

后续开发建议从 [docs/codex-goals/master-roadmap.md](docs/codex-goals/master-roadmap.md) 逐个复制 `/goal` 执行:

1. 用户研究冲刺: 采集真实证据, 完成主场景决策。
2. Agent 协议扩展: 强化 16 个角色的协作矩阵、审查链路和输出包格式。
3. Orchestrator 实现: 做最小任务路由、风险分级、审批状态和审计日志工程骨架。
4. Phase 1 POC: 用设备输入模拟器打通主场景闭环, 不承诺量产。
5. 评估体系: 用回放用例评估正确性、可执行性、风险识别、成本和人工修改量。
6. 安全合规强化: 完善访问控制、数据保留、威胁模型和 PR 安全门禁。

如果需要调度多个 Agent, 优先让 Codex 读取 `workflows/*.yaml`、`docs/agents/handoff-contract.md` 和对应角色协议。当前推荐路线是先用 YAML 做确定性路由, 再在 POC 阶段评估 OpenAI Agents SDK、LangGraph 或 Microsoft Agent Framework 等运行时。

本地 Codex Skill 安装:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/install-local-codex-agents.ps1
powershell -ExecutionPolicy Bypass -File scripts/verify-local-codex-agents.ps1
```

最小 Orchestrator 原型命令:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/invoke-orchestrator.ps1 -Workflow workflows/user-research-sprint.yaml -TaskId TASK-EXAMPLE-001 -Goal "用户研究冲刺"
```

每个目标完成前都应运行:

```powershell
git diff --check
powershell -ExecutionPolicy Bypass -File scripts/validate-docs.ps1
powershell -ExecutionPolicy Bypass -File scripts/validate-schemas.ps1
powershell -ExecutionPolicy Bypass -File scripts/run-evals.ps1
powershell -ExecutionPolicy Bypass -File scripts/verify-local-codex-agents.ps1
```

## 当前阶段的核心假设

- 参考产品暂定为“桌面/随身 AI 工作助理硬件”: 麦克风、摄像头或低功耗视觉传感器、小屏幕或指示灯、边缘唤醒、云端推理与 Agent 协作。
- 最终硬件形态可以替换为桌面设备、胸牌、会议终端、智能音箱、开发板套件或工业场景设备。
- 创始人只有一个人, 所以 Agents 不只是聊天角色, 而是覆盖产品、研发、供应链、合规、销售和运营的工作流系统。
- 所有人类不可外包的责任由创始人最终审批: 资金支出、供应商签约、法律合规、上市承诺、隐私策略和安全例外。
