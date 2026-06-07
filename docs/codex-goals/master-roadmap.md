# Codex Agents 后续开发总路线

## 使用方式

每次只复制一个 `/goal` 到 Codex。完成前要求 Codex 根据该目标的 Verification 和 Stop Conditions 自检、提交并同步。所有高风险动作, 包括付款、签约、对外发送、隐私策略、安全例外和量产承诺, 必须保留创始人审批。

## 1. 用户研究冲刺

```text
/goal
Objective: 在当前 Agents_for_star 仓库完成一轮智能 AI 硬件 OPC 用户研究冲刺, 形成可用于主场景决策的事实源, 不编造任何访谈或市场数据。

Context:
- 仓库已有 `docs/research/` 模板、`docs/product/prd-v1.md` 和 `docs/research/main-scenario-decision.md`。
- 未采集数据必须写为“未采集”, 不确定结论写为“待验证”。

Deliverables:
- 更新 `docs/research/interview-record-template.md`, 增加可复制访谈记录样例结构, 但不填写虚构受访者。
- 更新 `docs/research/pain-scorecard.md`, 明确痛点评分规则和证据要求。
- 更新 `docs/research/pilot-interest-board.md`, 增加试点意向字段和审批边界。
- 更新 `docs/research/main-scenario-decision.md`, 输出主场景决策表和下一轮验证问题。

Requirements:
- 不得编造用户、公司、预算、意向、访谈结论或市场规模。
- 涉及客户联系、对外发送、激励付款或使用原始录音截图时, 必须进入创始人审批。
- 文档使用中文, 结果可直接作为 Product Manager Agent 和 CEO Strategy Agent 输入。

Verification:
- 运行 `git diff --check`。
- 运行 `powershell -ExecutionPolicy Bypass -File scripts/validate-docs.ps1`。
- 搜索禁用占位词和乱码字符。

Stop Conditions:
- 用户研究文档可直接指导下一轮真实访谈。
- 所有未采集数据都有明确标注。
- 本地提交并同步到 GitHub origin/main。
```

## 2. Agent 协议扩展

```text
/goal
Objective: 基于 `docs/agents/roles/` 的 16 个 Agent 独立协议, 扩展跨 Agent 协作、任务路由和输出验收规则, 让后续 Codex Agents 能按角色稳定执行。

Context:
- 现有角色包括 CEO Strategy、Product、Hardware、Firmware、AI ML、Backend、App UX、QA、Supply Chain、Compliance、Security、Finance、Marketing、Sales、Customer Success、Knowledge Ops。
- 每个角色协议必须保留使命、职责边界、输入、输出、工具权限、禁止动作、升级审批条件、失败处理和指标。

Deliverables:
- 更新 `docs/agents/role-registry.md`, 增加角色间协作矩阵和审查链路。
- 为 `docs/agents/roles/` 增加统一输出包格式和 Owner 交接规则。
- 更新 `docs/agents/agent-role-protocol-template.md`, 保持与独立角色协议一致。
- 增加至少 8 个跨 Agent 任务样例, 指明主 Agent、审查 Agent、审批条件和输出路径。

Requirements:
- 不得减少创始人审批边界。
- 不得引入自动付款、签约、对外发送、隐私策略变更或安全例外执行能力。
- 文档必须中文、可执行、路径可追踪。

Verification:
- 检查 16 个 Agent 文件全部存在。
- 运行 `git diff --check`。
- 运行 `powershell -ExecutionPolicy Bypass -File scripts/validate-docs.ps1`。

Stop Conditions:
- 任一后续任务都能通过角色注册表确定主 Agent、审查 Agent 和审批边界。
- 本地提交并同步到 GitHub origin/main。
```

## 3. Orchestrator 实现

```text
/goal
Objective: 在当前仓库实现 Phase 1 POC 所需的最小 Orchestrator 工程骨架, 支持任务风险识别、Agent 路由、审批状态和审计日志。

Context:
- 设计依据在 `docs/orchestrator/` 和 `docs/phase-1-poc/architecture.md`。
- POC 只服务一个主场景, 不连接真实付款、签约、邮件群发、生产密钥或外部客户系统。

Deliverables:
- 创建最小工程目录, 包含任务输入模型、风险分级、路由规则、审批状态机和审计日志写入。
- 增加本地示例任务和回放命令。
- 增加测试覆盖低风险自动执行、中风险审查、高风险等待创始人审批三类路径。
- 更新 README 或 POC 文档说明运行方式。

Requirements:
- 保持依赖简单, 不引入不必要服务。
- 高风险动作只能输出审批包, 不得执行。
- 审计日志必须包含任务、Agent、工具、风险等级、审批状态和证据路径。

Verification:
- 运行项目测试命令。
- 运行 `git diff --check`。
- 运行 `powershell -ExecutionPolicy Bypass -File scripts/validate-docs.ps1`。
- 人工检查高风险测试没有真实外部调用。

Stop Conditions:
- 本地能运行示例 Orchestrator 流程。
- 高风险动作被阻断并生成审批包。
- 本地提交并同步到 GitHub origin/main。
```

## 4. Phase 1 POC

```text
/goal
Objective: 基于 `docs/phase-1-poc/` 完成 Phase 1 POC 的最小可演示版本, 验证一个主场景从设备输入到 Agent 建议再到创始人审批的闭环。

Context:
- POC 只服务一个主场景。
- 不承诺 EVT、DVT、PVT、Launch 或量产。
- 设备输入可使用模拟器, 不要求真实硬件。

Deliverables:
- 实现或完善设备输入模拟器。
- 实现主链路 Demo: 输入事件、任务路由、Agent 输出、风险判断、创始人审批、审计日志。
- 更新 `docs/phase-1-poc/demo-script.md`、`test-plan.md` 和 `acceptance-checklist.md`。
- 输出 POC 复盘记录草案。

Requirements:
- 不使用真实客户敏感数据。
- 不连接真实付款、签约、对外发送或生产凭据。
- 所有失败和限制必须写入验收清单。

Verification:
- 运行 POC 本地演示命令。
- 运行测试命令。
- 运行 `git diff --check`。
- 运行 `powershell -ExecutionPolicy Bypass -File scripts/validate-docs.ps1`。

Stop Conditions:
- POC 主链路可在本地复现。
- 验收清单明确通过、失败和待验证项目。
- 本地提交并同步到 GitHub origin/main。
```

## 5. 评估体系

```text
/goal
Objective: 建立 Agent 输出评估体系, 用回放用例衡量正确性、可执行性、风险识别、成本和人工修改量。

Context:
- 现有评估入口在 `docs/evaluation/`。
- 不得编造模型价格、基准分数、用户数据或成本结果。

Deliverables:
- 更新 `docs/evaluation/agent-output-rubric.md`, 增加评分细则和失败阈值。
- 更新 `docs/evaluation/task-replay-cases.md`, 增加不少于 12 个不含敏感数据的回放用例。
- 更新 `docs/evaluation/failure-taxonomy.md`, 映射失败类型到修复动作。
- 更新 `docs/evaluation/model-cost-quality-tracker.md`, 保留待验证价格字段和人工修改量字段。
- 如已有工程骨架, 增加可运行评估脚本。

Requirements:
- 评估必须覆盖正确性、可执行性、风险识别、成本、人工修改量。
- 高风险任务必须评估是否正确升级审批。
- 成本和价格未知时必须写为待验证。

Verification:
- 运行评估脚本或说明未实现脚本原因。
- 运行 `git diff --check`。
- 运行 `powershell -ExecutionPolicy Bypass -File scripts/validate-docs.ps1`。

Stop Conditions:
- 至少一组 Agent 输出可以按 rubric 人工或脚本评分。
- 本地提交并同步到 GitHub origin/main。
```

## 6. 安全合规强化

```text
/goal
Objective: 强化当前仓库的安全合规设计, 明确数据保留、访问控制、审批政策、威胁模型和 POC 安全门禁。

Context:
- 现有文件包括 `docs/security/threat-model.md`、`docs/security/access-control-matrix.md`、`docs/compliance/privacy-impact-assessment.md`、`docs/compliance/data-retention-policy-draft.md` 和 `docs/compliance/founder-approval-policy.md`。
- 合规文档必须标注为产品设计初稿, 不是法律意见。

Deliverables:
- 更新访问控制矩阵, 覆盖 Agent、Orchestrator、创始人、外部顾问和资源分级。
- 更新数据保留政策草案, 覆盖采集、保留、删除、外部模型使用和审批。
- 更新威胁模型, 增加 POC 主链路攻击面和缓解动作。
- 更新创始人审批政策, 增加审批包示例和拒绝/过期处理。
- 增加安全合规检查清单, 可作为 PR 门禁。

Requirements:
- 不得写成法律意见或认证结论。
- 不得批准安全例外、隐私策略发布或客户可见政策。
- 所有高风险动作必须保留创始人审批。

Verification:
- 运行 `git diff --check`。
- 运行 `powershell -ExecutionPolicy Bypass -File scripts/validate-docs.ps1`。
- 人工检查每个安全合规文档都包含产品设计初稿边界。

Stop Conditions:
- 安全合规文档可以直接作为 POC PR 检查依据。
- 本地提交并同步到 GitHub origin/main。
```
