# mac环境初始化

## 备份

- 微信聊天记录
- rsa秘钥
- 检查所有git仓库，是否已经push
- 检查${HOME}目录，注意.开头的隐藏目录
- 确认群晖cloud drive文件均已同步

## 初始化

### 基础工具

- ssh key（私钥600权限，其他644）
- clone工具箱仓库
- [brew](https://brew.sh/)

### 软链配置文件

- `mac/scripts/ln-init.sh`

### app store

- 登录iCloud & appStore
- moom
- the unarchiver
- manico
- sleep control center
- pastenow

### brew

- `mac/brew/install.sh`

### node

- `mac/scripts/node.sh`

- [avwo/whistle: HTTP, HTTP2, HTTPS, Websocket debugging proxy (github.com)](https://github.com/avwo/whistle)

### 终端

1. oh-my-zsh/p10k/zsh插件：`mac/scripts/install_zsh_stack.sh`
2. iterm2 color schemes
   - nerd font
   - 字号：17
   - color scheme：tango dark
   - 透明度：22
3. [lrzsz配置](https://github.com/kuoruan/iterm2-zmodem)


### 其他

- [peterldowns/iterm2-finder-tools: Open iTerm2 from the Finder (github.com)](https://github.com/peterldowns/iterm2-finder-tools)
- [MonitorControl/MonitorControl: 🖥 Control your display's brightness & volume on your Mac as if it was a native Apple Display. Use Apple Keyboard keys or custom shortcuts. Shows the native macOS OSDs. (github.com)](https://github.com/MonitorControl/MonitorControl)
- vscode：`cmd+shift+p：install code`
- typora：[图床服务](https://github.com/lwabish/typora-qiniu-uploader)

### 【废弃】l2tp vpn连接问题

osx 12疑似已经修复了l2tp vpn无法连接问题

`sudo vim /etc/ppp/options`

```
plugin L2TP.ppp
l2tpnoipsec
```
