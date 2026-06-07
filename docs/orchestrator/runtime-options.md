# Agent 运行时选型

## 目的

比较后续把本仓库的 Codex Agents 调度规范工程化时可选择的运行时。本文是产品和工程设计初稿, 不代表已经采用任何框架。

## 选型标准

| 标准 | 说明 |
|---|---|
| 人工审批 | 能否强制 high risk 进入创始人审批 |
| 可观测性 | 是否支持 trace、审计日志和失败回放 |
| 状态恢复 | 是否支持 checkpoint 或可恢复长任务 |
| 配置化 | 是否能把 workflow 放入 Git 管理 |
| 依赖复杂度 | 是否适合当前一人公司维护 |
| 评估接入 | 是否容易接入 eval case 和 CI gate |

## 候选方案

| 方案 | 优点 | 风险 | 当前建议 |
|---|---|---|---|
| 纯 Codex + Markdown/YAML | 最简单, 适合 docs-first, 不增加依赖 | 需要人工提示 Codex 执行调度 | 当前采用 |
| OpenAI Agents SDK | handoff、guardrail、tracing 概念直接匹配 | 需要进入工程实现和运行时维护 | POC 后候选 |
| LangGraph | 状态图、checkpoint、human-in-the-loop 成熟 | 图结构和依赖复杂度更高 | 复杂长流程时评估 |
| Microsoft Agent Framework | 多 Agent 工作流和治理能力强 | 技术栈和集成成本待验证 | 企业级流程时评估 |
| Conductor 风格 YAML | 配置可版本控制, 适合当前仓库 | 需要自建执行器或由 Codex 解释执行 | 当前借鉴 |
| CrewAI / MetaGPT / ChatDev 风格角色协作 | 角色化流程清晰 | 自治闭环可能越过创始人审批 | 只借鉴组织方式 |

## 推荐路线

### Phase A: 当前

- 使用 Codex 读取 `workflows/*.yaml`。
- 由 Codex 根据 workflow 选择主 Agent 和审查 Agent。
- 所有输出写入仓库事实源。
- `scripts/validate-docs.ps1` 负责基础校验。

### Phase B: POC 工程骨架

- 增加一个轻量 Orchestrator 脚本或服务。
- 读取 workflow YAML。
- 生成审计日志和审批包。
- 只执行 low risk 内部任务。

### Phase C: 运行时框架评估

- 用同一组 eval cases 比较 OpenAI Agents SDK、LangGraph 或 Microsoft Agent Framework。
- 评估维度包括人工审批、trace、checkpoint、成本、维护复杂度和失败恢复。
- 未完成评估前不绑定单一框架。

## 运行时评估矩阵

评分: 1 为弱, 3 为可用, 5 为强。分数是当前产品设计判断, 不是 benchmark。

| 方案 | 创始人审批 | Trace 和审计 | Checkpoint | Workflow 配置 | 维护复杂度 | 依赖成本 | 当前适配度 |
|---|---:|---:|---:|---:|---:|---:|---:|
| 纯 YAML + PowerShell 脚本 | 5 | 3 | 2 | 5 | 5 | 5 | 5 |
| OpenAI Agents SDK | 4 | 5 | 3 | 3 | 3 | 待验证 | 4 |
| LangGraph | 5 | 4 | 5 | 4 | 3 | 待验证 | 4 |
| Microsoft Agent Framework | 5 | 5 | 5 | 4 | 2 | 待验证 | 3 |
| CrewAI | 3 | 3 | 2 | 3 | 3 | 待验证 | 2 |
| MetaGPT / ChatDev 风格 | 2 | 2 | 2 | 3 | 2 | 待验证 | 2 |

## 矩阵结论

当前阶段继续采用“纯 YAML + PowerShell 脚本”作为最小运行时:

- 能直接读取 `workflows/*.yaml`。
- 能生成主 Agent、审查 Agent、风险等级、审批状态和审计日志草案。
- 能通过 `scripts/validate-schemas.ps1` 和 `scripts/run-evals.ps1` 做基础回放。
- 不新增依赖, 适合一人公司维护。

后续进入真实多 Agent 执行时, 优先比较 OpenAI Agents SDK 和 LangGraph:

- 如果重点是 handoff、guardrail 和 tracing, 优先评估 OpenAI Agents SDK。
- 如果重点是长任务状态、checkpoint 和 human-in-the-loop, 优先评估 LangGraph。
- 如果进入企业级治理或复杂并发流程, 再评估 Microsoft Agent Framework。

## 选型触发条件

| 触发条件 | 动作 |
|---|---|
| workflow 数量超过 10 个 | 增加更严格 schema 或运行时评估 |
| high risk 审批包每周超过 5 个 | 增加审批队列和审计索引 |
| 需要恢复中断任务 | 评估 checkpoint 运行时 |
| 需要真实模型调用和工具执行 | 评估 OpenAI Agents SDK 或 LangGraph |
| 需要团队协作和 PR 门禁 | 强化 GitHub Actions CI |

## 创始人审批事项

- 引入付费 API 或云资源。
- 安装会影响生产系统的运行时。
- 使用外部模型处理敏感数据。
- 自动化任何对外发送、付款、签约、隐私策略、安全例外或量产承诺动作。
