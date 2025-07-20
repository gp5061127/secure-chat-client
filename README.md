📱 secure-chat-client
secure-chat-client 是使用 Flutter 编写的加密通信客户端，支持通过 WebSocket 与 secure-chat 服务端进行通信，实现用户注册、登录、私聊和群聊功能。

✨ 功能特性
用户注册 / 登录（用户名 + 密码）

加密通信（配合服务端使用）

支持私聊与群聊

支持自动保持在线与消息接收

🚀 安装与运行
1. 克隆项目
```bash
git clone https://github.com/gp5061127/secure-chat-client.git
cd secure-chat-client
```
2. 安装依赖
```bash
flutter pub 
```
3. 运行客户端
连接真实设备或模拟器后运行：

```bash
flutter run
```
⚙️ 配置说明
请在 lib/config.dart 文件中设置服务端地址：

```dart
const String serverUrl = "ws://your-server-ip:端口/ws";
```
若使用了域名 + TLS，请替换为 wss:// 开头的地址。

🧪 开发环境要求
Flutter SDK（3.x）

Dart SDK

Android Studio / VS Code

Android 模拟器或真实设备

📂 项目结构
```bash

lib/
 ├── main.dart                # 应用入口
 ├── config.dart              # 服务端地址配置
 ├── pages/                   # 各页面
 ├── services/                # API 接口服务封装
 └── models/                  # 数据模型
 ```
🛡️ 安全建议
###此项目为教学演示用途，未做完善身份验证机制。

若用于生产环境，请务必：

替换 JWT 密钥

使用 HTTPS / WSS 协议

增加权限控制与限流机制

使用更安全的身份验证方式（如 OAuth2）

👨‍💻 开发者
由 gp5061127 (数蛆蹲厕所) 开发维护。
服务端仓库：secure-chat-server
客户端仓库：secure-chat-client

