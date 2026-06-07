# 硬件设计评审清单

## 使用方式

Hardware Architect Agent 在 POC、自研 PCB、样机 bring-up 或 EVT 前使用本清单。每项必须标为通过、阻断、待验证或不适用。

## 系统级

| 检查项 | 状态 | 证据路径 | Owner |
|---|---|---|---|
| 主场景和硬件必要性清楚 | 待验证 | `docs/product/prd-v1.md` | Product Manager Agent |
| 传感器、主控、电源、无线、显示、外壳边界清楚 | 待验证 | 未采集 | Hardware Architect Agent |
| 隐私相关能力有物理提示和关闭路径 | 待验证 | `docs/security/access-control-matrix.md` | Security Agent |
| 开发板 Demo 与自研 PCB 差异已列出 | 待验证 | 未采集 | Hardware Architect Agent |

## 原理图

| 检查项 | 状态 | 证据路径 | Owner |
|---|---|---|---|
| 电源树包含电压、电流、上电顺序和测量点 | 待验证 | 未采集 | Hardware Architect Agent |
| 每个关键 IC 有去耦、复位、启动模式和调试接口 | 待验证 | 未采集 | Hardware Architect Agent |
| USB-C、音频、摄像头、无线和外部连接器有保护策略 | 待验证 | 未采集 | Hardware Architect Agent |
| 关键网络命名清楚, 便于固件和测试引用 | 待验证 | 未采集 | Firmware Agent |
| ERC 或等效检查无阻断项 | 待验证 | 未采集 | Hardware Architect Agent |

## PCB 和结构

| 检查项 | 状态 | 证据路径 | Owner |
|---|---|---|---|
| PCB 规则按制造能力设置, 未使用默认规则直接出板 | 待验证 | 未采集 | Hardware Architect Agent |
| 关键电源、地、时钟、USB、音频和射频布局有约束 | 待验证 | 未采集 | Hardware Architect Agent |
| 测试点覆盖电源轨、复位、调试口、关键总线和传感器接口 | 待验证 | 未采集 | QA Reliability Agent |
| 外壳开孔、按键、状态灯、散热和装配方向可检查 | 待验证 | 未采集 | Hardware Architect Agent |
| DRC 或等效检查无阻断项 | 待验证 | 未采集 | Hardware Architect Agent |

## DFM/DFT/DFA

| 检查项 | 状态 | 证据路径 | Owner |
|---|---|---|---|
| 器件封装可采购、可焊接、可返修 | 待验证 | 未采集 | Supply Chain Agent |
| 有最小测试夹具或调试线方案 | 待验证 | 未采集 | QA Reliability Agent |
| Silkscreen、版本号、方向标识、连接器标识清楚 | 待验证 | 未采集 | Hardware Architect Agent |
| BOM 包含替代料、生命周期和风险 | 待验证 | `docs/hardware/bom-template.md` | Supply Chain Agent |

## 评审结论

| 结论 | 含义 |
|---|---|
| 通过 | 可进入下一阶段 |
| 有条件通过 | 必须关闭指定风险后进入下一阶段 |
| 阻断 | 不允许进入下一阶段 |
| 降级 | 回到开发板或软件模拟路径 |
