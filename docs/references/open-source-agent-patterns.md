# 开源 Agent 项目借鉴分析

## 目的

本文记录可借鉴的开源 Agent 项目模式, 用于完善本仓库的 Codex Agents 调度、审批、评估和工程化路线。本文不引入运行时依赖, 只把成熟模式转化为当前 docs-first 阶段可执行的规范。

## 参考项目

| 项目 | 可借鉴模式 | 当前落地方式 | 暂不照搬原因 |
|---|---|---|---|
| OpenAI Agents SDK | handoff、guardrail、tracing、结构化输出 | 定义 Agent 交接合约、审批拦截和审计字段 | 当前仓库尚未进入生产运行时实现 |
| LangGraph | 状态图、human-in-the-loop、checkpoint、长期任务恢复 | 用 workflow YAML 表达状态流和审批节点 | 先保持简单, 不引入图运行时 |
| Microsoft Agent Framework | 多 Agent 工作流、checkpoint、并发、治理和观测 | 把任务路由、审查链路和审批状态拆成可验证配置 | 当前没有 .NET 或 Python 服务骨架 |
| Microsoft Conductor | YAML 化、确定性路由、版本控制的多 Agent 工作流 | 新增 `workflows/*.yaml` 作为调度事实源 | 不直接运行, 先作为 Codex 调度配置 |
| CrewAI | role、task、crew、process 的角色协作结构 | 保持 `docs/agents/roles/` + workflow 中的 primary/reviewer | Crew 式自治过强, 高风险动作需创始人审批 |
| MetaGPT | 软件公司角色、SOP、阶段性交付物 | 强化 OPC 虚拟公司角色和输出包格式 | 本项目是智能硬件 OPC, 不是纯软件交付 |
| ChatDev | 虚拟公司、配置化流程、跨角色讨论 | 增加跨 Agent 任务样例和审查链路 | 不能让 Agent 自行闭环高风险商业动作 |
| promptfoo | LLM eval、red team、CI gate、回放测试 | 新增 eval gate 和 YAML 样例 | 当前先做文档和样例, 后续再接入工具 |

## 设计原则

1. 确定性优先: 先由 workflow 配置明确主 Agent、审查 Agent、风险等级和输出路径。
2. 审批优先: 高风险动作必须生成审批包, 不允许自动执行。
3. 可回放优先: Agent 输出必须能被 eval case 复盘, 不只依赖主观判断。
4. 审计优先: 每次 handoff、guardrail 和审批都要有记录字段。
5. 简单优先: 当前阶段不引入框架依赖, 等 POC 需要时再选择运行时。

## 映射到本仓库

| 开源模式 | 本仓库文件 |
|---|---|
| Agent role | `docs/agents/roles/*.md` |
| Handoff | `docs/agents/handoff-contract.md` |
| Workflow graph | `workflows/*.yaml` |
| Guardrail | `docs/orchestrator/approval-state-machine.md`、`docs/orchestrator/tool-permission-model.md` |
| Trace | `docs/orchestrator/audit-log-schema.md` |
| Eval | `docs/evaluation/`、`evals/*.yaml` |
| Human-in-the-loop | `docs/compliance/founder-approval-policy.md` |

## 推荐吸收顺序

1. Conductor 风格 workflow YAML: 低成本把调度规则变成配置。
2. OpenAI Agents SDK 风格 handoff contract: 统一 Agent 交接输入输出。
3. promptfoo 风格 eval gate: 对高风险升级、事实引用和输出质量做回放。
4. LangGraph 风格状态恢复: 等 Orchestrator 工程骨架出现后再实现 checkpoint。
5. Microsoft Agent Framework 或 OpenAI Agents SDK 运行时: 等 POC 需要真实执行多 Agent 工作流时再决策。

## 风险边界

- 不把任何参考项目的“自动执行”能力用于付款、签约、对外发送、隐私策略、安全例外或量产承诺。
- 不把公开项目能力写成当前仓库已经具备的工程实现。
- 不编造 benchmark、成本、生产可用性或模型价格。
- 任何外部依赖引入都必须进入创始人审批和技术评审。
