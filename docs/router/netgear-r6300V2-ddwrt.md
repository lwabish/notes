---
layout: post
cid: 13
title: 【废弃】Netgear R6300V2刷ddwrt
slug: r6300-ddwrt-1
date: 2015/05/07 00:03:00
updated: 2018/12/16 19:42:52
status: hidden
author: lwabish
categories: 
  - 技术
tags: 
  - 数字生活
previewContent: 
thumbnail: 
---


## 刷入ddwrt

特别提示：路由器刷机需要用电脑通过网线连接lan口的方式进行，不能在无线连接下进行。

1. 如果之前从未刷过ddwrt，则先在[这里](http://www.desipro.de/ddwrt-ren/K3-AC-Arm/Initial/)下载过渡包。这个网页里关于R6300v2的chk固件包有两个，一个叫dd-wrt.K3_R6300V2.chk，另一个叫dd-wrt.K3_R6300V2ch.chk。这两个都是针对R6300v2的，但是带ch的貌似是特别为原固件为中国版的路由器准备的。我一开始使用了带ch的，但是提示无法更新，所以换用不带ch的刷成功了。
2. 下载过渡包后，在官方固件的升级固件处刷入。
3. 刷完路由器自动重启后，进入http://192.168.1.1，此时可以看见已经是ddwrt的界面了。首先更改管理用户名和密码。
4. 在ddwrt中的management里找到language，里面可以把界面语言改为简体中文。
5. 在[这里](http://www.desipro.de/ddwrt-ren/K3-AC-Arm/)下载完整版的ddwrt固件，一般是数字加M结尾的目录，下载其中的.bin结尾的文件。
6. 同样在192.168.1.1的ddwrt界面找到固件升级，选中上一步的包，刷入即为完整的ddwrt。

## 刷入后ddwrt的设置

由于我已经刷回了网件的固件，之前也忘记截图，所以把chiphell上的图放在这里，方便以后需要时查看。

### 无线安全设置

注意加密方式是personal，选business得话连wifi会要求输入用户名和密码

![img](http://www.chiphell.com/data/attachment/forum/201401/29/105933cno188dc65p01fe1.jpg)

 

### 2.4G无线的设置

![img](http://www.chiphell.com/data/attachment/forum/201401/29/105933w33a98w86x3koxid.jpg)

 

### 5G无线的设置

![img](http://www.chiphell.com/data/attachment/forum/201402/14/063522ciifhz0nhh70bhnn.png)

 

## ddwrt刷回netgear固件

直接去netgear官网下载对应R6300v2机型的固件，在ddwrt中刷入即可，注意也要用网线连接的方式。