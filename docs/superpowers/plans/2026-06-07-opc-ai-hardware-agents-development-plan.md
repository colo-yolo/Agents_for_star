# OPC AI Hardware Agents Development Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 建立并持续扩展智能 AI 硬件 OPC 多角色 Agent 规划仓库。

**Architecture:** 以 GitHub 文档为第一事实源, 先完成 Agent 智能与开发规划, 再逐步扩展 PRD、硬件、供应链、合规、安全、财务和市场销售资料。Codex `/goal` 使用短目标引用详细任务书, 避免目标长度限制。

**Tech Stack:** Markdown, Git, GitHub, Codex CLI, PowerShell verification commands.

---

### Task 1: 仓库入口和长期规则

**Files:**
- Create or modify: `README.md`
- Create or modify: `AGENTS.md`

- [ ] **Step 1: 检查仓库状态**

Run:

```powershell
git status --short --branch
```

Expected: 输出当前分支和是否有未提交变更。

- [ ] **Step 2: 核对 README 内容**

Ensure `README.md` includes:

```text
仓库目标
主要文档
推荐使用方式
当前阶段的核心假设
```

- [ ] **Step 3: 核对 AGENTS.md 内容**

Ensure `AGENTS.md` includes:

```text
工作语言
仓库目标
事实源
变更规则
验证规则
```

- [ ] **Step 4: 验证文件存在**

Run:

```powershell
Test-Path README.md; Test-Path AGENTS.md
```

Expected: 两行输出均为 `True`。

### Task 2: Agent 智能与开发规划

**Files:**
- Create or modify: `docs/agent-intelligence-and-development-plan.md`

- [ ] **Step 1: 核对核心章节**

Ensure the document includes:

```text
一句话定位
参考产品边界
OPC 总体架构
Agent 智能等级
多角色 Agents 设计
Agent 协作工作流
数据和记忆架构
技术架构建议
开发路线图
关键风险和控制
90 天优先行动
成功标准
```

- [ ] **Step 2: 核对 Agent 覆盖**

Search for these role names:

```text
CEO Strategy Agent
Product Manager Agent
Hardware Architect Agent
Firmware Agent
AI ML Agent
Backend Agent
App UX Agent
QA Reliability Agent
Supply Chain Agent
Compliance Agent
Security Agent
Finance Agent
Marketing Agent
Sales Agent
Customer Success Agent
Knowledge Ops Agent
```

- [ ] **Step 3: 核对开发阶段**

Search for:

```text
Phase 0
Phase 1
Phase 2
Phase 3
Phase 4
Phase 5
POC
EVT
DVT
PVT
Launch
```

- [ ] **Step 4: 验证文件存在**

Run:

```powershell
Test-Path docs/agent-intelligence-and-development-plan.md
```

Expected: 输出 `True`。

### Task 3: Codex `/goal` prompt

**Files:**
- Create or modify: `docs/codex-goal-prompt.md`

- [ ] **Step 1: 核对短 prompt**

Ensure the document contains a copyable command beginning with:

```text
/goal
```

The short prompt must point to:

```text
docs/codex-goal-prompt.md
```

- [ ] **Step 2: 核对完整任务书结构**

Ensure the full task brief contains:

```text
Objective
Context
Deliverables
Requirements
Verification
Stop Conditions
```

- [ ] **Step 3: 核对短目标引用方式**

Ensure the document explains:

```text
短 `/goal` + 本文件详细任务书
```

- [ ] **Step 4: 验证文件存在**

Run:

```powershell
Test-Path docs/codex-goal-prompt.md
```

Expected: 输出 `True`。

### Task 4: 规格和计划文档

**Files:**
- Create or modify: `docs/superpowers/specs/2026-06-07-opc-ai-hardware-agents-design.md`
- Create or modify: `docs/superpowers/plans/2026-06-07-opc-ai-hardware-agents-development-plan.md`

- [ ] **Step 1: 核对规格文档**

Ensure the spec includes:

```text
Intent
Assumptions
Architecture
Components
Data Flow
Error Handling
Verification
Acceptance Criteria
```

- [ ] **Step 2: 核对计划文档**

Ensure this plan includes:

```text
Task 1
Task 2
Task 3
Task 4
Task 5
Task 6
```

- [ ] **Step 3: 验证文件存在**

Run:

```powershell
Test-Path docs/superpowers/specs/2026-06-07-opc-ai-hardware-agents-design.md; Test-Path docs/superpowers/plans/2026-06-07-opc-ai-hardware-agents-development-plan.md
```

Expected: 两行输出均为 `True`。

### Task 5: 文档质量检查

**Files:**
- Inspect: all Markdown files

- [ ] **Step 1: 搜索占位词**

Run:

```powershell
$terms = @('T'+'BD', 'TO'+'DO', '待'+'补充', 'PLACE'+'HOLDER')
Select-String -Path (Get-ChildItem -Recurse -Filter *.md).FullName -Pattern ($terms -join '|')
```

Expected: 无匹配结果。

- [ ] **Step 2: 检查补丁空白问题**

Run:

```powershell
git diff --check
```

Expected: 无输出, exit code 为 0。

- [ ] **Step 3: 检查工作区变更**

Run:

```powershell
git status --short --branch
```

Expected: 显示新增或修改的 Markdown 文件。

### Task 6: 提交和同步

**Files:**
- Commit all planned files.

- [ ] **Step 1: 创建本地提交**

Run:

```powershell
git add README.md AGENTS.md docs
git commit -m "docs: add opc ai hardware agent plan"
```

Expected: Git 创建一个提交。

- [ ] **Step 2: 推送到 GitHub**

Run:

```powershell
git push -u origin main
```

Expected: 推送到 `https://github.com/colo-yolo/Agents_for_star.git` 的 `main` 分支。

- [ ] **Step 3: 推送失败处理**

If push fails because authentication is unavailable, report:

```text
本地提交已创建, 但 GitHub 推送因为认证失败未完成。请在本机完成 GitHub 登录后运行 git push -u origin main。
```

- [ ] **Step 4: 最终状态检查**

Run:

```powershell
git status --short --branch
```

Expected after successful push: 分支跟踪 `origin/main`, 工作区干净。
