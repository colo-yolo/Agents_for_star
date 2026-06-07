# 本地 Codex Agent 配置

## 目的

把本仓库的 Agents for Star 角色系统安装为本机 Codex Skill, 让本地 Codex 可以直接按 workflow 调度主 Agent、审查 Agent、风险等级、审批包和审计日志草案。

## 已配置的 Skill

| Skill | 本地路径 | 用途 |
|---|---|---|
| agents-for-star-orchestrator | `C:\Users\ASUS\.codex\skills\agents-for-star-orchestrator` | 按 Principal 能力标准调度本仓库 16 个 Agent 角色和 workflow |

## 安装命令

在仓库根目录运行:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\install-local-codex-agents.ps1
```

该脚本会把 `codex-skills/agents-for-star-orchestrator` 复制到 `C:\Users\ASUS\.codex\skills\agents-for-star-orchestrator`。

## 使用方式

在本地 Codex 中直接说:

```text
请使用 agents-for-star-orchestrator 调度用户研究冲刺。
```

或:

```text
请调度 Agents for Star 的 Product Manager Agent 和 Compliance Agent，准备一个客户访谈邀请草稿。涉及对外发送时只生成创始人审批包，不发送。
```

复审或升级 Agent 系统本身时可以说:

```text
请使用 agents-for-star-orchestrator 调度 Principal Agent 能力复审，检查 16 个角色协议、本地 Codex Skill、workflow、eval 和审批边界。
```

## 触发后的执行规则

1. Skill 先读取 `docs/codex-operator-playbook.md`。
2. 读取 `docs/agents/principal-agent-capability-standard.md`, 所有角色按 Principal 级工作方式执行。
3. 选择 `workflows/*.yaml`, Agent 系统复审使用 `workflows/principal-agent-review.yaml`。
4. 运行 `scripts/invoke-orchestrator.ps1`。
5. 根据输出读取 `docs/agents/roles/*.md`。
6. high risk 只输出 founder approval package。
7. 结束前运行文档、Agent 能力、schema、eval 和本地安装验证。

## 验证

```powershell
powershell -ExecutionPolicy Bypass -File scripts\install-local-codex-agents.ps1
powershell -ExecutionPolicy Bypass -File scripts\validate-docs.ps1
powershell -ExecutionPolicy Bypass -File scripts\validate-agent-capabilities.ps1
powershell -ExecutionPolicy Bypass -File scripts\validate-schemas.ps1
powershell -ExecutionPolicy Bypass -File scripts\run-evals.ps1
powershell -ExecutionPolicy Bypass -File scripts\verify-local-codex-agents.ps1
```

## 限制

- 当前配置是 Skill 级调度, 不是独立多进程 Agent 运行时。
- Agent 的真实协议仍以仓库 `docs/agents/roles/*.md` 为准。
- Agent 能力标准以 `docs/agents/principal-agent-capability-standard.md` 为准。
- 付款、签约、对外发送、隐私策略、安全例外和量产承诺必须停在创始人审批包。
