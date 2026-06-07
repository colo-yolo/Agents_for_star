# 样例: BOM 风险审查

## 输入

- 任务: 审查 BOM 中关键器件、替代料和采购风险。
- 事实源: `docs/hardware/bom-template.md`。

## 调度

| 字段 | 内容 |
|---|---|
| 主 Agent | Hardware Architect Agent |
| 审查 Agent | Supply Chain Agent、Finance Agent、Security Agent |
| 风险等级 | high |
| 输出路径 | `docs/hardware/bom-template.md`, `docs/strategy/risk-register.md` |

## 建议 `/goal`

```text
/goal
请按 BOM 风险审查样例调度 Agent。主 Agent 为 Hardware Architect Agent, 审查 Agent 为 Supply Chain Agent、Finance Agent、Security Agent。不得编造价格、库存、交期、认证或供应商承诺。任何下单、付款、询价发送或供应商签约都必须生成创始人审批包。
```

## 输出

- 关键器件风险。
- 替代料候选字段。
- 待验证价格和交期。
- 采购审批包草案。

## 审批

采购、付款、供应商沟通、NDA 和合同全部需要创始人审批。

## 验收

- 报价、库存、交期未验证时写为待验证。
- 不承诺量产供应稳定性。
- Security Agent 审查摄像头、麦克风、无线通信等敏感能力。
