## bios修改

1. 默认显卡改成集成显卡
2. 集成显卡保持开启
3. 支持legacy启动
4. 开启vt-d

## 安装unraid

1. 下载unraid官方的flasher。

2. 选择版本。注意stable版本(6.8)实测识别不了网卡，使用next版本(6.9rc2)可以正常识别。
3. 在flasher里进行网络配置，static
4. 不开启uefi，使用传统bios启动。
5. 引导启动，接显示器进终端，确认获取了ipv4地址
6. 浏览器进登录页面

## 初始化配置

1. ntp

2. 激活or试用
3. 存储池配置&阵列自动启动，
4. [community app](https://raw.githubusercontent.com/Squidly271/community.applications/master/plugins/community.applications.plg)
5. 中文

6. U盘共享关闭

7. isos共享下拷贝系统镜像iso

8. virtio镜像下载：settings vm manager

9. 直通相关设置

![](https://cdn.wubw.fun/typora/210629-101724-WX20210130-170247@2x.png)

## 参考

[UnRAID 6/Getting Started - unRAID](https://wiki.unraid.net/UnRAID_6/Getting_Started)

https://www.bilibili.com/video/BV1Ya4y1L7hM

