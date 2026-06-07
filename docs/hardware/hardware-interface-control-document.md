# 硬件接口控制文档

## 目的

定义 Hardware Architect Agent 与 Firmware、Backend、QA、Security 等 Agent 的交接接口。接口文档用于减少口头假设, 支持 bring-up、测试和审计。

## 接口总览

| 接口 | Owner | 消费方 | 状态 |
|---|---|---|---|
| 电源轨 | Hardware Architect Agent | Firmware、QA | 待验证 |
| 调试口 | Hardware Architect Agent | Firmware、QA | 待验证 |
| 麦克风输入 | Hardware Architect Agent | Firmware、AI ML | 待验证 |
| 摄像头或视觉传感器 | Hardware Architect Agent | Firmware、Security、Compliance | 待验证 |
| 状态灯或屏幕 | Hardware Architect Agent | App UX、QA | 待验证 |
| 物理按键和静音键 | Hardware Architect Agent | Firmware、App UX、Security | 待验证 |
| Wi-Fi/BLE/USB | Hardware Architect Agent | Backend、Firmware、Security | 待验证 |

## 接口字段

| 字段 | 说明 |
|---|---|
| interface_id | 接口编号 |
| electrical_level | 电平、供电、保护 |
| protocol | I2C、SPI、UART、USB、GPIO、I2S 等 |
| timing | 采样率、启动时序、复位时序 |
| owner_agent | 负责 Agent |
| test_method | 测试方法 |
| failure_mode | 常见失效模式 |
| log_signal | 固件或后端日志字段 |

## 示例

| 字段 | 内容 |
|---|---|
| interface_id | AUDIO-MIC-001 |
| electrical_level | 待验证 |
| protocol | I2S 或 USB Audio, 待验证 |
| timing | 采样率待验证 |
| owner_agent | Hardware Architect Agent |
| test_method | 办公室噪声输入、静音键、状态灯联动 |
| failure_mode | 噪声过高、通道错误、隐私提示失效 |
| log_signal | mic_state、mute_state、audio_input_error |

## 交接规则

- Firmware Agent 不应在接口字段缺失时假设引脚、电平或时序。
- QA Reliability Agent 必须能从接口字段生成测试用例。
- Security Agent 必须审查摄像头、麦克风、无线和外部接口。
- Compliance Agent 必须审查涉及用户数据采集和提示的接口。
