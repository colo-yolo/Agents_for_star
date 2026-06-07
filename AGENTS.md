# AGENTS.md

## 工作语言

- 默认用中文输出面向用户的规划、总结和交付物。
- 技术标识、命令、路径、API 名称和 Git 分支名保持英文原样。

## 仓库目标

本仓库服务于一个智能 AI 硬件产品的一人公司, OPC, 多角色 Agent 操作系统。工作重点是把产品、Agent 智能、开发路线、验证标准和 Codex `/goal` 输入维护成可执行文档。

## 事实源

- 产品与 Agent 规划以 `docs/agent-intelligence-and-development-plan.md` 为准。
- Codex `/goal` 任务输入以 `docs/codex-goal-prompt.md` 为准。
- 规格与执行计划分别维护在 `docs/superpowers/specs/` 和 `docs/superpowers/plans/`。
- 不要把未验证的市场数据、价格、认证费用、供应商交期或法规要求写成事实。需要当前事实时先联网验证并标注来源。

## 变更规则

- 优先编辑现有文档, 避免无必要地新增重复文件。
- 所有新增规划都要包含可验证交付物和停止条件。
- 涉及硬件、合规、隐私、安全、资金和商业承诺的内容必须保留人工审批门槛。
- 不要提交密钥、供应商私密报价、个人身份数据或未脱敏客户访谈。

## 验证规则

每次声称完成前至少运行:

```powershell
git status --short --branch
git diff --check
```

如果修改了 Markdown 文档, 还要人工核对:

- 关键文件存在。
- 没有常见英文或中文占位文字。
- `/goal` prompt 包含目标、交付物、需求、验证和停止条件。
- Agent 规划覆盖产品、研发、供应链、合规、市场销售、运营和财务。

如果修改本地 Codex Agent 调度配置, 还要运行:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/install-local-codex-agents.ps1
powershell -ExecutionPolicy Bypass -File scripts/verify-local-codex-agents.ps1
```
