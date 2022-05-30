## 旧版清理

> 重点：清理docker mount到宿主的目录，因为一旦修改后，下次会反向mount

- /mnt/user/isos/BigSur-opencore.img
- /mnt/user/isos/BigSur-install.img
- /mnt/user/domains/Macinabox BigSur/macos_disk.img
- /mnt/user/system/custom_ovmf
- /mnt/user/appdata/macinabox
- 容器
- 镜像
- 旧vm：`vm virsh undefine --nvram "Macinabox BigSur"`，然后即可删除vm
- 旧的template：docker-add container，下拉列表里的user-macinabox，点x删掉

直接删除虚机，重启macinabox容器，然后运行user script即可重新建立新的虚机。

vnc无法连接：关闭浏览器重新开即可。

## 安装插件

- ca user scripts
- vm_custom_icons
- macinabox

## macinabox配置

>已经被修复：
>
>If you keep getting Catalina instead of BIg Sur try this                                                                                                                                                                                                                                                                                                                                                                   From the Container template edit screen in the WebGUI, set "Download Method" to method2  After you change it to Method 2 and apply, and while the container is running, click the icon on the docker tab and click console.  Type  vi ../Macinabox/[unraid.sh ](https://www.youtube.com/redirect?event=comments&redir_token=QUFFLUhqa1ZZb3JyV3pmNWMzNDBMVUZ3TTJJNjlxWGNZQXxBQ3Jtc0ttV2hQbzEwamdNM3BneDkzTG4xY1lqc2RhaXc2TVZIaDJzeXhMVzhBWHpwcC1rSDVlSl9qUU4zQk1QVy0zbGNYMFVGeXBmTDI3bkFUQ2xEaGw0WmJuNFl0d1FZM2NycUFaVUYyLTNLX0xMNmFsZzJBZw&q=http%3A%2F%2Funraid.sh%2F&stzid=Ugxdjh2_Rb2HSKSbmD94AaABAg)  Go to line 250 and press i to edit  change 001-86606 to 071-05432  press escape then :wq to save

- ~~注意：初步看/Macinabox/unraid.sh代码，怀疑选择method2时fixxml函数执行前卡住，导致user script没有出现。手工执行脚本解决。~~

- 版本
- 磁盘大小

## 等待完成

 - settings-user script-1_macinabox_vmready_notify：background run，等待通知

   ![image-20210306165110431](https://cdn.wubw.fun/typora/210629-101733-image-20210306165110431.png)

 -  同样的位置，运行1_macinabox_helper ，至此黑苹果的vm可见

## 开始mac安装

start vnc，正常安系统流程，抹盘，安装。

## 驱动及配置

进系统后：

- opencore configurator
- 菜单tools： mount efi
- mount EFI o
- copy all to desktop
- mount & paste to APFS container

选择机型：

- 刚拷贝的efi/oc/config.plist，右键opencore configurator打开
- 左侧platform info选机型
- check coverage确认序列号不可用
- 点叉退出，save。关机

## 硬件配置优化

编辑vm：

- cpu 内存
- 删除多余的磁盘：把3的路径移到1，删除23
- update
- edit user script1
  - vm name
  - ~~改firstinstall为no~~
  - cpu核心数非标准则改removetopology为yes
  - save  & run script1
- 开机验证

## 切显卡（集成显卡）

没成功，跳过，改用独显

> Passing through an igpu has always been more problematic than a regular gpu. 
>
> I guess you havent had sucess with igpu passthough with any vms as yet.
>
> Using a regular gpu will be much easier. I beleive the gt730 supports metal so should be okay in macOS. The gpu that i use for macOS is a sapphire rx570 pulse itx which works also natively.

## kepler补丁mac 12需要

[Monterey with NVIDIA graphic cards (Kepler series) support thread | tonymacx86.com](https://www.tonymacx86.com/threads/monterey-with-nvidia-graphic-cards-kepler-series-support-thread.316553/)

## 切显卡（独显）+声卡音频

- 关机
- 按需edit vm
  - 在图形界面下选择独显和对应的声音输出
  - 在xml下编辑multifunction（参考windows篇内容）
- user script 1 run： fix xml
- **GTX760+mini hdmi**

## usb设备直通 

- 键盘
- 鼠标

## 蓝牙

未能成功

[USB Map 解决 AX200 蓝牙不出现的问题-黑苹果 Big Sur 11.5.2-TUF B550M PLUS WI-FI_das2m的博客-CSDN博客_ax200 蓝牙 黑苹果](https://blog.csdn.net/zhangyingda/article/details/119861412)

[USB Mapping | OpenCore Post-Install (dortania.github.io)](https://dortania.github.io/OpenCore-Post-Install/usb/intel-mapping/intel.html)

[黑苹果定制USB如此操作，USBmap工具操作简单，阿风瞎折腾记EP05 - YouTube](https://www.youtube.com/watch?v=IbMQlA8278s)

[【黑苹果】快速且方便定制 USB 映射的方法（Windows 定制法） @ -Ben's PHOTO- ：： 痞客邦 ：： (pixnet.net)](https://benjenq.pixnet.net/blog/post/48066812-【黑蘋果】快速且方便定製-usb-映射的方法（w)

[关于黑苹果的 USB 映射 (mechanus.io)](https://mechanus.io/guan-yu-hei-ping-guo-de-usb-ying-she/)

## 显示器分辨率问题

参考博客中rdm记录

## 睡眠问题

禁用睡眠

## docker

嵌套虚拟化支持，虚机里使用dockerhttps://forums.unraid.net/topic/84430-hackintosh-tips-to-make-a-bare-metal-macos/?do=findComment&comment=849306

## 其他

- virt manager built in docker
  - macinabox web console
  - 连接qemu root+宿主机ip
  - 典型应用：当前的unraid版本有bug，vnc改显卡后，vnc还在，用virtmanager移除vnc和video cirrus，最后依然需要修复xml

## 参考

https://www.youtube.com/watch?v=7OunFLG84Qs

[WhateverGreen/FAQ.IntelHD.en.md at master · acidanthera/WhateverGreen (github.com)](https://github.com/acidanthera/WhateverGreen/blob/master/Manual/FAQ.IntelHD.en.md)