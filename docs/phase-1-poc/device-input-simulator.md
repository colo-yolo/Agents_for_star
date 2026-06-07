# 设备输入模拟方案

用途: 在真实硬件前, 用文本或简单 CLI 模拟硬件输入。

## 输入样例

```text
source: simulated_voice
goal: 将今天客户反馈整理成下周产品优先级
context: docs/product/prd-v1.md
risk_hint: medium
requested_output: product_priority_draft
```

## POC 输入文件格式

建议路径: `docs/phase-1-poc/sample-inputs/`

| 字段 | 必需 | 说明 |
|---|---|---|
| source | 是 | simulated_voice、text、manual |
| goal | 是 | 创始人的自然语言目标 |
| context_paths | 否 | 相关文档路径 |
| risk_hint | 否 | low、medium、high |
| requested_output | 是 | 期望输出 |

## 验收

- 能从一个输入样例生成任务路由结果。
- 能识别高风险动作并进入审批流。
- 输出能写入 GitHub 文档草案。

