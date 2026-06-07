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

## 创始人审批事项

- 引入付费 API 或云资源。
- 安装会影响生产系统的运行时。
- 使用外部模型处理敏感数据。
- 自动化任何对外发送、付款、签约、隐私策略、安全例外或量产承诺动作。
