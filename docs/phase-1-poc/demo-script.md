# Phase 1 POC Demo 脚本

## Demo 目标

展示创始人如何通过模拟硬件入口创建任务, 由 Orchestrator 路由给多角色 Agent, 生成文档草案, 并对高风险动作进行审批。

## 演示流程

1. 输入任务: “把今天客户反馈整理成下周产品优先级。”
2. Orchestrator 输出主 Agent 和审查 Agent。
3. Product Manager Agent 生成需求归类草案。
4. Knowledge Ops Agent 建议写入事实源。
5. 若任务要求对外发送, 系统进入 Founder Approval。
6. 审计日志记录输入、Agent、输出和审批状态。

## 成功画面

- 能看到任务路由结果。
- 能看到 Agent 草案。
- 能看到审批门禁。
- 能看到写入路径或 issue 草案。

## 不演示

- 真实付款。
- 真实对外发送。
- 真实量产硬件。
- 真实客户隐私数据。

