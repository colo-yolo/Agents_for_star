# Codex `/goal` 输入 Prompt

日期: 2026-06-07

## 使用说明

建议使用“短 `/goal` + 本文件详细任务书”的方式。短目标用于告诉 Codex 读取仓库内的任务书, 详细上下文保存在文件中, 便于后续会话继续推进和逐项验证。

## 推荐直接复制的 `/goal`

```text
/goal 请在当前仓库继续推进 Agents for Star: 以 docs/codex-goal-prompt.md 作为任务书, 完成智能 AI 硬件 OPC 多角色 Agent 规划仓库的后续建设、校验、提交和同步。完成前必须逐项核对任务书中的 Deliverables、Requirements、Verification 和 Stop Conditions。
```

## 完整任务书

以下内容供 Codex 在执行 `/goal` 后读取。本节可以持续扩展, 并作为仓库中的长期任务书维护。

```markdown
Objective:
把 https://github.com/colo-yolo/Agents_for_star.git 建设成一个可执行的智能 AI 硬件产品 OPC, One Person Company, 多角色 Agent 规划仓库。仓库必须同时给出 Agents 的智能规划、产品到量产的开发规划、未来 Codex 可继续执行的任务结构, 并同步到 GitHub。

Context:
- 用户希望开发一个智能 AI 硬件产品, 借助多角色 Agent 实现一人公司。
- 当前阶段重点是规划、架构、角色定义、路线图和后续 Codex 任务输入, 不是立即量产硬件。
- 参考产品可以采用“桌面/随身 AI 工作助理硬件 + 云端 Agent 控制台”的可替换形态。
- GitHub 仓库是唯一事实源。重要结论必须写进仓库文件, 不能只留在聊天记录。
- `/goal` 使用短目标引用仓库内详细任务书, 避免把完整需求只放在一次性聊天记录中。

Deliverables:
- `README.md`: 说明仓库目标、主要文档、推荐 `/goal` 用法和当前假设。
- `AGENTS.md`: 规定 Codex 在本仓库中的语言、事实源、变更规则和验证规则。
- `docs/agent-intelligence-and-development-plan.md`: 详细说明智能 AI 硬件 OPC 的 Agent 架构、角色智能、协作流程、数据记忆、技术架构、开发路线图、风险和 90 天行动计划。
- `docs/codex-goal-prompt.md`: 提供可直接复制的 `/goal` 短 prompt 和完整任务书。
- `docs/superpowers/specs/2026-06-07-opc-ai-hardware-agents-design.md`: 当前阶段设计规格。
- `docs/superpowers/plans/2026-06-07-opc-ai-hardware-agents-development-plan.md`: 后续建设和验证计划。

Requirements:
- 全部面向用户的主要内容使用中文。
- 不能把未验证的市场数据、供应商价格、法规认证费用或模型价格写成事实。
- Agent 角色必须覆盖战略、产品、硬件、固件、AI、后端、前端或控制台、QA、供应链、合规、安全、财务、市场、销售、客户成功和知识运营。
- 每个关键 Agent 至少说明职责、智能能力、输入、输出、工具边界和指标。
- 开发规划必须覆盖 POC、EVT、DVT、PVT 和 Launch 或运营阶段。
- 必须明确哪些动作可以由 Agent 自动执行, 哪些动作必须由创始人人工审批。
- `/goal` prompt 必须包含 Objective、Context、Deliverables、Requirements、Verification 和 Stop Conditions。
- 不要删除用户已有文件或未理解的改动。
- 如需联网验证当前事实, 只采用可信来源并在文档或最终答复中标注链接。

Verification:
- 运行 `git status --short --branch` 检查分支和工作区。
- 运行 `git diff --check` 检查空白和补丁问题。
- 检查上述 Deliverables 文件全部存在。
- 搜索仓库中是否存在常见英文或中文占位词, 如存在必须改成具体内容。
- 人工核对 `docs/agent-intelligence-and-development-plan.md` 是否覆盖 Agent 架构、角色矩阵、开发阶段、风险和 90 天计划。
- 人工核对 `docs/codex-goal-prompt.md` 是否包含可复制短 `/goal` 和完整任务书。
- 如果本地 Git 可提交, 创建提交。
- 如果 GitHub 认证可用, 推送到 `origin main`。如果推送失败, 保留本地提交并在最终答复中说明失败原因和下一步命令。

Stop Conditions:
- 只有当所有 Deliverables 都存在、Verification 通过、没有占位内容、Git 状态已解释清楚, 并且 GitHub 同步成功或明确报告认证阻塞时, 才能停止。
- 如果推送失败但本地提交已完成, 不要声称已同步到 GitHub。必须明确说明还需要用户完成认证或手动推送。
- 如果发现目标范围过大, 不要缩小目标。先完成规划仓库这个可验证阶段, 再给出下一阶段建议。
```

## 下一次可选增强目标

当本仓库基础文档完成后, 可以追加第二个 `/goal`:

```text
/goal 基于当前仓库文档, 继续创建 Phase 0 的可执行工作区: 增加 docs/strategy、docs/product、docs/hardware、docs/security、docs/compliance、docs/finance、docs/go-to-market 目录, 生成 PRD v1、风险登记册、决策记录模板、BOM 初稿模板、用户访谈脚本和第一批 GitHub issue 草案。完成前运行文档完整性检查并提交。
```
