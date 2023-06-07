# IM-Select-Remote

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/mkdir700/im-select-remote/default.yml?branch=main&style=for-the-badge)
![Lua](https://img.shields.io/badge/Made%20with%20Lua-blueviolet.svg?style=for-the-badge&logo=lua)

一个用于在远程服务器上切换本机输入法的 VIM 插件。

## Preparation

切换输入法您需要安装第三方工具，我这里推荐使用 [im-select](https://github.com/daipeihust/im-select)，当我执行如下命令即可切换至 ABC 输入法：

```
im-select com.apple.keylayout.ABC
```

所以，逻辑非常简单，就是让远程服务器调用本机用于切换输入法的命令即可。

## Installation

- packer

```lua
use { 'mkdir700/im-select-remote' }
```

## Configuration

### SSH + Socket (推荐)

#### 配置 SSH

配置文件路径：`~/.ssh/config`

- 本机

```
Host <your server name>
  HostName <your hostname>
  User <username>
  Port 22
  RemoteForward 127.0.0.1:23333 127.0.0.1:23333  -- 用于端口转发
  ServerAliveInterval 240
Host *
  ForwardAgent yes
```

- 远程

```
Host local
  HostName localhost
  Port 23333
  User <username>
```

#### 启动 Socket 服务

IM-Select-Remote 可以连接 Socket 服务以通知本地机器切换输入法，所以本地机器需要开启一个 Socket 服务。

```bash
git clone https://github.com/mkdir700/im-select-remote.git
chmod +x ./im-select-remote/server/im_server.sh
./im-select-remote/server/im_server.sh
```

- 自启动

Mac OS:

```bash
launchctl load ./launch/localhost.im-server.plist
launchctl start localhost.im-select.plist
launchctl status localhost.im-select.plist
```

Linux:

```bash
TODO
```

注意：

打开 NVIM 后，IM-Select-Remote 会去判断是否已配置 SSH，这将作为是否自动连接的前提条件。如果检查通过将连接 Socket 服务，否则最多重试三次后就放弃连接。

此外，您也可以执行 `IMSelectSocketEnable` 进行手动连接。

### OSC (等待测试)

TODO

## Usage

自动切换输入法的触发时机：

- 进入缓冲区时
- 从输入模式回到正常模式时

## Thanks

- https://github.com/daipeihust/im-select
- https://github.com/ojroques/nvim-osc52
