# 本地 Codex Agent 配置

## 目的

把本仓库的 Agents for Star 角色系统安装到本机 Codex, 让本地 Codex 可以通过普通 Skill 和插件 slash 指令调度主 Agent、审查 Agent、风险等级、审批包和审计日志草案。

## 已配置入口

| 入口 | 本地路径 | 用途 |
|---|---|---|
| `agents-for-star-orchestrator` | `C:\Users\ASUS\.codex\skills\agents-for-star-orchestrator` | 普通 Codex Skill 入口, 按 Principal 能力标准调度本仓库 16 个 Agent 角色和 workflow |
| `agents-for-star@agents-for-star-local` | `plugins/agents-for-star` | 本仓库本地 Codex 插件, 提供 `/star-*` slash 指令入口 |

## Slash 指令

安装插件后, 在新的 Codex 会话中输入 `/`, 可以用中文关键词或英文 slug 搜索入口。为了保持 Codex slash 命令稳定, 实际命令名仍使用 `/star-*`, 但菜单显示名、说明和默认提示已中文化。

推荐调度方式:

1. 输入 `/`。
2. 搜索 `产品`、`安全`、`硬件`、`财务`、`总调度` 等中文关键词。
3. 选择对应 Agent。
4. 在同一条消息里写清目标、事实源、期望交付物和风险边界。

| Slash 指令 | 默认主 Agent | 典型用途 |
|---|---|---|
| `/star-orchestrator` | Orchestrator | 自动选择 workflow 并协调多个 Agent |
| `/star-ceo-strategy` | CEO Strategy Agent | 路线图、OKR、资源取舍、预算权衡 |
| `/star-product-manager` | Product Manager Agent | PRD、用户研究、MVP 范围、验收标准 |
| `/star-hardware-architect` | Hardware Architect Agent | 硬件架构、BOM、PCB、EVT、FMEA |
| `/star-firmware` | Firmware Agent | 固件状态机、OTA、日志、低功耗、安全启动 |
| `/star-ai-ml` | AI ML Agent | 模型策略、提示词、eval、模型成本 |
| `/star-backend` | Backend Agent | Orchestrator、API、审计日志、权限模型 |
| `/star-app-ux` | App UX Agent | 控制台、审批流、设备状态、风险文案 |
| `/star-qa-reliability` | QA Reliability Agent | 测试计划、回归门禁、缺陷分类、replay case |
| `/star-supply-chain` | Supply Chain Agent | BOM、供应商、替代料、采购风险 |
| `/star-compliance` | Compliance Agent | 隐私、认证、数据保留、合规风险 |
| `/star-security` | Security Agent | 威胁模型、权限、密钥、安全例外 |
| `/star-finance` | Finance Agent | 预算、现金流、单台经济性、付款审批 |
| `/star-marketing` | Marketing Agent | 定位、内容、发布材料、外部 claim |
| `/star-sales` | Sales Agent | ICP、线索、demo、客户跟进、报价草案 |
| `/star-customer-success` | Customer Success Agent | 试点反馈、支持草稿、问题复现、价值验证 |
| `/star-knowledge-ops` | Knowledge Ops Agent | 文档结构、决策记录、周报、下一步 `/goal` |

菜单中的中文显示名示例:

| 搜索词 | 菜单显示 | 实际命令 |
|---|---|---|
| `总调度` | 总调度 Orchestrator | `/star-orchestrator` |
| `产品` | 产品经理 Agent | `/star-product-manager` |
| `硬件` | 硬件架构 Agent | `/star-hardware-architect` |
| `安全` | 安全 Agent | `/star-security` |
| `合规` | 合规 Agent | `/star-compliance` |
| `财务` | 财务 Agent | `/star-finance` |
| `知识` | 知识运营 Agent | `/star-knowledge-ops` |

插件卡片和每个 slash 入口都配置了本地图标资源:

- `plugins/agents-for-star/assets/star-agent.svg`
- `plugins/agents-for-star/assets/star-agent-small.svg`

## 安装命令

在仓库根目录运行:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\install-local-codex-agents.ps1
```

该脚本会执行四件事:

1. 生成 `plugins/agents-for-star` 和 `.agents/plugins/marketplace.json`。
2. 读取 `docs/agents/local-codex-slash-ui.zh-CN.json` 生成中文菜单文案和默认提示。
3. 把 `codex-skills/agents-for-star-orchestrator` 复制到 `C:\Users\ASUS\.codex\skills\agents-for-star-orchestrator`。
4. 校验插件 manifest。
5. 执行 `codex plugin marketplace add .` 和 `codex plugin add agents-for-star@agents-for-star-local`。

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

也可以直接使用 slash 指令:

```text
/star-product-manager
请基于 docs/product/prd-v1.md 复审 MVP 范围, 同时让 Compliance Agent 和 QA Reliability Agent 提供审查意见。
```

```text
/star-security
请复审 Orchestrator 的权限模型和审计日志, 涉及安全例外时只输出创始人审批包。
```

如果你想让系统自动选角色, 使用总调度:

```text
/star-orchestrator
请基于 docs/product/prd-v1.md 和 docs/phase-1-poc/architecture.md, 判断当前 POC 下一步最该推进什么, 输出主 Agent、审查 Agent、风险等级、交付物和停止条件。
```

如果你已经知道要哪个角色, 直接选该角色:

```text
/star-hardware-architect
请复审 docs/hardware/bom-template.md 和 docs/hardware/hardware-fmea-template.md, 找出 EVT 前必须补齐的硬件风险项。涉及量产承诺时只输出创始人审批包。
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

插件状态可用以下命令人工确认:

```powershell
codex plugin marketplace list
codex plugin list --available --json
```

预期结果:

- `codex plugin marketplace list` 包含 `agents-for-star-local`。
- `codex plugin list --available --json` 的 `installed` 中包含 `agents-for-star@agents-for-star-local`。
- 新的 Codex 会话里 `/` 菜单可以搜索 `总调度`、`产品`、`安全`、`star-orchestrator`、`star-product-manager`、`star-security` 等入口。

## 限制

- 当前配置是 Codex Skill 和 Codex Plugin 级调度, 不是独立多进程 Agent 运行时。
- Agent 的真实协议仍以仓库 `docs/agents/roles/*.md` 为准。
- Agent 能力标准以 `docs/agents/principal-agent-capability-standard.md` 为准。
- 付款、签约、对外发送、隐私策略、安全例外和量产承诺必须停在创始人审批包。
