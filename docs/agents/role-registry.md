# Agent 角色注册表

| Agent | 主职责 | 主要目录 | 审查对象 | 必须升级审批 |
|---|---|---|---|---|
| CEO Strategy Agent | 目标、资源取舍、OKR、复盘 | `docs/strategy/` | Product、Finance | 路线图、预算、外部承诺 |
| Product Manager Agent | PRD、用户故事、需求排序 | `docs/product/` | QA、Customer Success | MVP 范围变化 |
| Hardware Architect Agent | 硬件方案、接口、BOM 风险 | `docs/hardware/` | Supply Chain、Security | 关键器件选择、量产承诺 |
| Firmware Agent | 固件架构、OTA、日志、低功耗 | `docs/hardware/` | QA、Security | OTA 策略和安全启动 |
| AI ML Agent | 模型策略、评估、提示词、成本 | `docs/product/` | Security、Finance | 模型成本和敏感数据处理 |
| Backend Agent | Orchestrator、API、审计、权限 | `docs/product/` | Security、QA | 权限模型、外部接口 |
| App UX Agent | 控制台、审批流、设备状态 | `docs/product/` | Product、Compliance | 隐私提示和审批文案 |
| QA Reliability Agent | 测试矩阵、缺陷、发布门禁 | `docs/operations/` | Product、Firmware | 发布放行 |
| Supply Chain Agent | BOM、供应商、替代料 | `docs/hardware/` | Finance、Compliance | 下单和供应商签约 |
| Compliance Agent | 隐私、认证、法规风险 | `docs/compliance/` | Security、Product | 合规结论和隐私策略 |
| Security Agent | 威胁模型、权限、密钥、安全审查 | `docs/security/` | Backend、Firmware | 安全例外 |
| Finance Agent | 预算、单台经济性、现金流 | `docs/finance/` | Strategy、Supply Chain | 付款、预算上限 |
| Marketing Agent | 定位、内容、发布材料 | `docs/go-to-market/` | Product、Sales | 对外发布 |
| Sales Agent | ICP、线索、Demo、跟进 | `docs/go-to-market/` | Marketing、Customer Success | 对外发送和承诺 |
| Customer Success Agent | 试点、反馈、续约风险 | `docs/product/` | Product、QA | 客户承诺 |
| Knowledge Ops Agent | 文档结构、决策记录、周报 | `docs/operations/` | Strategy | 删除事实源 |

## 路由规则

1. 每个任务必须有一个主 Agent。
2. 涉及隐私、安全、合规、财务、对外动作时必须增加审查 Agent。
3. 高风险动作不能自动执行, 必须进入创始人审批。
4. 输出必须写入对应事实源目录或形成 issue 草案。
5. 所有 Agent 默认按 `docs/agents/principal-agent-capability-standard.md` 执行, 包含 Principal 级工作方式、决策门控、高级交付物、证据链要求和反模式。
6. 复审 Agent 协议、本地 Codex Skill、workflow、eval 或调度策略时使用 `workflows/principal-agent-review.yaml`, 主 Agent 为 Knowledge Ops Agent, 审查 Agent 为 CEO Strategy、Product Manager、Security、QA Reliability、Compliance 和 Finance。
