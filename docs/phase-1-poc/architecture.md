# Phase 1 POC 架构

状态: 产品设计初稿

## 主场景

主场景暂定为“桌面或模拟硬件入口将创始人的语音或文本目标转成多角色 Agent 任务并写入 GitHub 事实源”。该场景在用户研究完成前为候选, 不能作为量产承诺。

## POC 范围

```text
Text or simulated voice input
  -> Device Input Simulator
  -> Orchestrator
  -> Product Manager Agent
  -> Knowledge Ops Agent
  -> Founder approval
  -> GitHub docs or issue draft
```

## 模块

| 模块 | 职责 | POC 方式 |
|---|---|---|
| Device Input Simulator | 模拟硬件输入 | CLI 或文本文件 |
| Orchestrator | 路由任务、评估风险 | 文档协议和简单脚本 |
| Agent Workspace | 调用角色协议输出草案 | Markdown 文件 |
| Founder Approval Flow | 高风险动作审批 | 审批状态文件 |
| Audit Log | 记录输入、输出和审批 | JSONL 或 Markdown |

## 非目标

- 不做量产硬件。
- 不接真实付款、合同、对外发送。
- 不存储原始音视频。
- 不承诺正式合规结论。

