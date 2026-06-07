# OPC AI Hardware Agents Design

日期: 2026-06-07

## Intent

为智能 AI 硬件产品建立一个可由 Codex 长任务继续推进的 OPC 多角色 Agent 规划仓库。当前阶段交付的是清晰、可执行、可验证的文档系统, 不是直接进入硬件量产或完整软件开发。

## Assumptions

- 产品参考形态是“桌面/随身 AI 工作助理硬件 + 云端 Agent 控制台”。
- 创始人是一人公司中的唯一最终审批人。
- Agent 的价值在于执行产品、研发、运营、供应链和市场销售流程, 不只是生成聊天回复。
- GitHub 仓库承载文档、决策、计划和后续任务。
- 当前仓库初始为空, 因此需要先建立文档骨架和长期规则。

## Architecture

系统分为四层:

1. Hardware Interface: 负责语音、视觉或传感器输入, 以及本地隐私状态反馈。
2. Agent Orchestrator: 负责拆解目标、选择角色 Agent、管理审批门禁和审计记录。
3. Role Agents: 覆盖战略、产品、硬件、固件、AI、后端、前端、QA、供应链、合规、安全、财务、市场、销售、客户成功和知识运营。
4. Systems of Record: GitHub、CRM、财务表、供应链表、测试证据和客户反馈库。

当前阶段只实现 Systems of Record 中的 GitHub 文档层。

## Components

### README

说明仓库定位、文档入口、推荐 `/goal` 用法和当前假设。它是新会话进入仓库时的第一阅读入口。

### AGENTS.md

为 Codex 提供长期仓库规则: 默认中文、事实源、敏感边界、验证要求。

### Agent Intelligence Plan

详细定义产品边界、Agent 智能等级、角色矩阵、协作流程、数据记忆、技术架构、阶段路线图、风险控制和 90 天行动。

### Codex Goal Prompt

提供短 `/goal` prompt 和完整任务书。短 prompt 用于指向仓库内任务书, 完整任务书用于保存详细上下文。

### Development Plan

把后续工作拆成可执行任务, 每个任务有目标文件、验证方式和退出标准。

## Data Flow

```text
Founder goal
  -> Codex /goal
  -> docs/codex-goal-prompt.md
  -> required documents
  -> verification commands
  -> git commit
  -> origin main
```

对于未来产品系统:

```text
Hardware input
  -> Orchestrator
  -> Role Agents
  -> Founder approval gates
  -> GitHub and operating systems
  -> review and metrics
```

## Error Handling

- 如果 GitHub 推送失败, 保留本地提交并说明认证或网络问题, 不声称同步完成。
- 如果发现外部事实不确定, 文档中写为假设或验证项, 不写成事实。
- 如果后续 Codex 目标过长或上下文复杂, 把任务书放入文件并用短 `/goal` 指向文件。
- 如果用户已有文件与规划冲突, 先读取并整合, 不直接覆盖。

## Verification

必须验证:

- 关键文件存在。
- Markdown 中没有占位词。
- `git diff --check` 通过。
- `docs/codex-goal-prompt.md` 包含短 `/goal` 和完整任务书。
- Agent 规划覆盖核心公司职能和硬件开发阶段。
- 本地提交和远端推送状态被明确报告。

## Acceptance Criteria

- 用户可以打开 README 并知道这个仓库做什么。
- 用户可以复制 `docs/codex-goal-prompt.md` 中的短 `/goal` 启动下一轮 Codex 长任务。
- 后续 Codex 会话能根据 AGENTS.md 和 docs 继续推进, 不需要重新解释目标。
- 文档对人类创始人的审批责任有清晰边界。
