# mac环境初始化

## 备份

- 微信聊天记录
- rsa秘钥
- 检查所有git仓库，是否已经push
- 检查${HOME}目录，注意.开头的隐藏目录

## 初始化

### 基础工具

- mellow & config

- brew

- ssh key（私钥600权限，其他644）,ssh配置

- 登录iCloud & appStore
- clone配置文件仓库，重新软链配置文件

### app store

- moom
- the unarchiver
- manico
- sleep control center
- ccopy或其他类似剪贴板工具

### brew

- `mac/brew/install.sh`

- vscode：`cmd+shift+p：install code`
- typora：[图床服务](https://github.com/lwabish/typora-qiniu-uploader)
- node：[改全局node_modules位置](https://segmentfault.com/a/1190000019500608)

### npm

[git cz](https://github.com/streamich/git-cz)

[avwo/whistle: HTTP, HTTP2, HTTPS, Websocket debugging proxy (github.com)](https://github.com/avwo/whistle)

### 其他

- [idea](https://www.jetbrains.com/zh-cn/idea/download/#section=mac)：修改maven为brew安装的老版本
- [peterldowns/iterm2-finder-tools: Open iTerm2 from the Finder (github.com)](https://github.com/peterldowns/iterm2-finder-tools)
- [MonitorControl/MonitorControl: 🖥 Control your display's brightness & volume on your Mac as if it was a native Apple Display. Use Apple Keyboard keys or custom shortcuts. Shows the native macOS OSDs. (github.com)](https://github.com/MonitorControl/MonitorControl)

### 终端

1. [安装oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh#basic-installation)：`sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
2. [nerd fonts](https://github.com/ryanoasis/nerd-fonts#option-4-homebrew-fonts)
3. p10k：`git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k`
5. 安oh my zsh插件
   - `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`
6. [lrzsz配置](https://github.com/kuoruan/iterm2-zmodem)
7. color schemes
8. 透明度和blur：22 & 2

### l2tp vpn连接问题

osx 12疑似已经修复了l2tp vpn无法连接问题

`sudo vim /etc/ppp/options`

```
plugin L2TP.ppp
l2tpnoipsec
```
