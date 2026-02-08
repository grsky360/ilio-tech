---
date: 2026-02-07 20:17:33 +08:00
lastmod: 2026-02-08 00:00:14 +08:00
title: openclaw 部署指南
share: true
---
## 简介
> 本文所配置环境均为云服务器

## 前置条件
- 一台服务器
- 本地 AI Gateway: [GitHub - songquanpeng/one-api: LLM API 管理 & 分发系统](https://github.com/songquanpeng/one-api)
- (可选) docker 镜像加速: [docker 镜像加速](https://ilio.top/posts/docker-%E9%95%9C%E5%83%8F%E5%8A%A0%E9%80%9F/)

## 所需Docker镜像
- openclaw: [alpine/openclaw - Docker Image](https://hub.docker.com/r/alpine/openclaw)
- (可选，AI Gateway) one-api: [Package one-api · GitHub](https://github.com/songquanpeng/one-api/pkgs/container/one-api)

## 步骤

### 1. 准备docker-compose
由于官方的docker-compose太过于冗余，并且有的配置是不生效的(预定义token)，因此精简了一下内容

具体可以参照: [docker-images/llm/openclaw at master · grsky360/docker-images · GitHub](https://github.com/grsky360/docker-images/tree/master/llm/openclaw)
- 使用 traefik 参考: [docker-compose-traefik.yml](https://github.com/grsky360/docker-images/blob/master/llm/openclaw/docker-compose-traefik.yml "docker-compose-traefik.yml")
	- 测试不能通过 chrome 进行访问，Traefik 对 RFC 8441不支持
	- [websocket with http/2 cleartext lead to http 500 · Issue #7465 · traefik/traefik · GitHub](https://github.com/traefik/traefik/issues/7465)
- 不使用 traefik 参考: [docker-compose.yml](https://github.com/grsky360/docker-images/blob/master/llm/openclaw/docker-compose.yml "docker-compose.yml")

### 2. setup环境
以下命令会交互式进行设置
```
docker compose run --rm openclaw onboard --no-install-daemon
```

> Onboarding complete. Use the tokenized dashboard link above to control OpenClaw.

等到有这个提示的时候就是 onboard 好了，可以 control+C 结束

### 3. 启动openclaw
```
docker compose up -d
```

### 4. 获取 gateway token 并保存
```
docker compose exec openclaw node dist/index.js config get gateway.auth.token
```

### 5. 登录页面进行设备配对
1. 访问地址, 例如: http://localhost:12345/overview
2. 填写你的 token
	1. 如果 token 不正确会提示: disconnected (1008): unauthorized: gateway token mismatch
3. 如果没有打开 insecureAuth
	1. 回到服务器
	2. 执行以下命令
	   ```
	   openclaw devices list # 确认 pending approve 的设备列表
	   openclaw devices approve {requestId} # 找到你的设备的 requestId 进行 approve
	   ```
	3. approve 之后, 回到页面, 会变成 Connected


## 常见问题
disconnected (1008): unauthorized: gateway token mismatch (open a tokenized dashboard URL or paste token in Control UI settings)
> 输入的 token 或者 password 不正确

disconnected (1008): pairing required
> 需要服务器进行 device pairing 和 approve


## 有用的命令
### 1. 执行任意 CLI 命令
- 仅在 onboard 并且启动 gateway 之后有效
- 仅限在 docker-compose 目录执行
```
alias openclaw="docker compose exec openclaw node dist/index.js"
```


### 2. 管理当前 gateway auth
```
获取当前 auth mode: openclaw config get gateway.auth.mode

设置为 token mode: openclaw config set gateway.auth.mode token
获取 auth token: openclaw config get gateway.auth.token
设置 auth token: openclaw config set gateway.auth.token XXX

设置为 password mode: openclaw config set gateway.auth.mode password
获取 auth password: openclaw config get gateway.auth.password
设置 auth password: openclaw config set gateway.auth.password
```

### 3. 关闭 web pairing (慎重)
```
openclaw config set gateway.controlUi.allowInsecureAuth true
docker compose restart
```


## 参考资料
- 官方文档: [Docker - OpenClaw](https://docs.openclaw.ai/install/docker)
- CLI Reference: [CLI Reference - OpenClaw](https://docs.openclaw.ai/cli)