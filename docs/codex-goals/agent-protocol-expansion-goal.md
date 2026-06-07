# Agent Protocol Expansion `/goal` Prompt

用途: 将 Agent 注册表扩展为每个角色独立协议文件。

```text
/goal 基于 docs/agents/role-registry.md 和 docs/agents/agent-role-protocol-template.md, 为 16 个核心 Agent 生成独立角色协议文件, 放入 docs/agents/roles/。每个文件必须包含使命、负责范围、输入、输出、工具权限、禁止动作、升级审批条件、失败处理和指标。涉及战略、产品、硬件、固件、AI、后端、控制台、QA、供应链、合规、安全、财务、市场、销售、客户成功和知识运营。完成前检查所有角色文件存在, 运行 git diff --check, 检查无占位词, 提交并同步 GitHub。
```

## Deliverables

- `docs/agents/roles/ceo-strategy-agent.md`
- `docs/agents/roles/product-manager-agent.md`
- `docs/agents/roles/hardware-architect-agent.md`
- `docs/agents/roles/firmware-agent.md`
- `docs/agents/roles/ai-ml-agent.md`
- `docs/agents/roles/backend-agent.md`
- `docs/agents/roles/app-ux-agent.md`
- `docs/agents/roles/qa-reliability-agent.md`
- `docs/agents/roles/supply-chain-agent.md`
- `docs/agents/roles/compliance-agent.md`
- `docs/agents/roles/security-agent.md`
- `docs/agents/roles/finance-agent.md`
- `docs/agents/roles/marketing-agent.md`
- `docs/agents/roles/sales-agent.md`
- `docs/agents/roles/customer-success-agent.md`
- `docs/agents/roles/knowledge-ops-agent.md`

## Verification

- 16 个文件全部存在。
- 每个文件都有升级审批条件。
- 每个文件都有禁止动作。
- 每个文件都有可量化指标。
