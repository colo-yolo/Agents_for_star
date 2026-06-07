# 失败分类

| 类型 | 描述 | 处理 |
|---|---|---|
| routing_error | 路由到错误 Agent | 更新路由规则 |
| risk_miss | 未识别高风险动作 | 更新风险词表和审批规则 |
| hallucinated_fact | 编造市场、用户、价格或法规事实 | 删除事实并标为待验证 |
| weak_actionability | 输出不可执行 | 增加 Owner、路径和验收 |
| privacy_leak | 暴露敏感信息 | 脱敏并进入安全复盘 |
| cost_blindness | 忽略成本 | 引入成本字段 |
| excessive_human_edit | 人工修改量过大 | 改写 Agent 协议 |

## 失败复盘字段

| 字段 | 内容 |
|---|---|
| failure_id | 由系统生成 |
| task_id | 关联任务 |
| failure_type | 上表之一 |
| severity | low、medium、high |
| root_cause | 由审查 Agent 填写 |
| fix | 具体修复 |
| owner | 负责 Agent |

