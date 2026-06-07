# Security Privacy Hardening `/goal` Prompt

用途: 在 POC 前强化隐私、安全和审批门禁。

```text
/goal 基于 docs/security/threat-model.md、docs/compliance/privacy-impact-assessment.md 和 docs/agents/role-registry.md, 扩展 POC 前安全隐私门禁。创建 docs/security/access-control-matrix.md、docs/security/audit-log-schema.md、docs/compliance/data-retention-policy-draft.md 和 docs/compliance/founder-approval-policy.md。必须明确低、中、高风险动作, 高风险动作不得自动执行。完成前运行 git diff --check, 检查无占位词, 提交并同步 GitHub。
```

## Deliverables

- `docs/security/access-control-matrix.md`
- `docs/security/audit-log-schema.md`
- `docs/compliance/data-retention-policy-draft.md`
- `docs/compliance/founder-approval-policy.md`

## Verification

- 所有高风险动作都需要创始人审批。
- 数据保留策略不承诺法律合规结论。
- 审计日志字段覆盖输入、Agent、工具、输出、审批和时间。
