---
layout: post
cid: 11
title: Netgear-r6300v2-merlin(梅林)固件
slug: merlin-show-aicloud
date: 2017/06/05 23:57:00
updated: 2018/12/16 20:07:41
status: hidden
author: lwabish
categories: 
  - 技术
tags: 
  - 数字生活
previewContent: 
thumbnail: 
---


## 刷入merlin
http://koolshare.cn/forum-96-1.html
## 重新显示aicloud组件
X7.0固件发布后很多人吐槽aicloud，usb应用，传统qos被砍掉了
也有很多人觉得这个确实没什么用，觉得精简的固件更稳定实用
辣么这里可以同时满足大家了，需要使用aicloud，usb应用，传统qos的朋友，请在用ssh客户端，telnet客户端，shellinaboxed插件等命令工具，输入以下命令：

1. nvram set NOASUS=0
2. nvram commit
3. reboot

复制代码，一次输入完也好，一条一条输入完都行，输入完毕后路由器会自动重启，重启完毕后你就会发现熟悉的阿苏斯应用了！重启路由器后依然有效，恢复出厂设置后失效。