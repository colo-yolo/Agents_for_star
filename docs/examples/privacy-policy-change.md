# 样例: 隐私策略变更审批

## 输入

- 任务: 评估是否调整 POC 数据采集、保留或删除策略。
- 事实源: `docs/compliance/data-retention-policy-draft.md`。

## 调度

| 字段 | 内容 |
|---|---|
| 主 Agent | Compliance Agent |
| 审查 Agent | Security Agent、Product Manager Agent |
| 风险等级 | high |
| 输出路径 | `docs/compliance/data-retention-policy-draft.md`, `docs/compliance/founder-approval-policy.md` |

## 建议 `/goal`

```text
/goal
请按隐私策略变更审批样例调度 Agent。主 Agent 为 Compliance Agent, 审查 Agent 为 Security Agent 和 Product Manager Agent。本文只能输出产品设计初稿, 不是法律意见。任何客户可见隐私政策、数据采集范围变化、数据删除或外部模型使用都必须生成创始人审批包。
```

## 输出

- 数据流和保留周期变更草案。
- 用户影响和产品影响。
- 安全风险。
- 外部专业审查问题清单。
- 创始人审批包。

## 审批

隐私策略、数据保留、数据删除、客户可见文本和外部模型处理敏感数据必须由创始人审批。

## 验收

- 明确标注产品设计初稿。
- 不写成法律意见。
- 不编造法规费用、认证周期或监管结论。
