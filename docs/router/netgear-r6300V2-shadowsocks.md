---
layout: post
cid: 14
title: 【废弃】Netgear R6300v2刷ddwrt后安装shadowsocks
slug: r6300-ddwrt-2
date: 2015/06/18 00:04:00
updated: 2018/12/16 19:43:56
status: hidden
author: lwabish
categories: 
  - 技术
tags: 
  - 数字生活
previewContent: 
thumbnail: 
---


## 准备

给R6300 V2刷入ddwrt，可正常上网使用即可。

## 开启JFFS

在ddwrt的管理选项卡中，把JFFS2支持打开。

## 拷贝主程序到路由器中

百度下载winscp,打开后，新建SFTP协议的会话，主机名为路由器的LAN地址(例如192.168.1.1)，用户名为root，密码为你在ddwrt中的管理登陆密码。

然后登陆，进入路由器的文件目录里，刚登陆目录会处于/tmp/root下，我们需要切到/jffs下，然后建立新文件夹shadowsocks，最后将shadowsocks-libev（[下载](http://file.wubowen.me/SS-ddwrt/shadowsocks-libev.tar.gz)）的压缩包里的四个文件扔进去。

## 建立shadowsocks配置文件

在/jffs/shadowsocks目录下，用WinSCP新建shadowsocks.json文件，内容如下：

```
{
    "server":"服务器地址",
    "server_port":服务器端口,
    "local_port":1080,
    "password":"密码",
    "timeout":300,
    "method":"aes-256-cfb"
}
```

服务器地址、端口、密码根据你的服务端配置填写，注意引号不要动。

建议先用[shadowsocks客户端](http://file.wubowen.me/Shadowsocks_Client/)测试过服务器可用后再部署到路由器中。

## 配置DNS

登陆路由器管理界面，在服务选项卡中找到DNSMasq，全部改为启用，并把下面的内容写进附加选项

```
server=/.google.com/208.67.220.220#443
server=/.google.com.hk/208.67.220.220#443
server=/.gstatic.com/208.67.220.220#443
server=/.ggpht.com/208.67.220.220#443
server=/.googleusercontent.com/208.67.220.220#443
server=/.appspot.com/208.67.220.220#443
server=/.googlecode.com/208.67.220.220#443
server=/.googleapis.com/208.67.220.220#443
server=/.gmail.com/208.67.220.220#443
server=/.google-analytics.com/208.67.220.220#443
server=/.youtube.com/208.67.220.220#443
server=/.googlevideo.com/208.67.220.220#443
server=/.youtube-nocookie.com/208.67.220.220#443
server=/.ytimg.com/208.67.220.220#443
server=/.blogspot.com/208.67.220.220#443
server=/.blogger.com/208.67.220.220#443
server=/.facebook.com/208.67.220.220#443
server=/.thefacebook.com/208.67.220.220#443
server=/.facebook.net/208.67.220.220#443
server=/.fbcdn.net/208.67.220.220#443
server=/.akamaihd.net/208.67.220.220#443
server=/.twitter.com/208.67.220.220#443
server=/.t.co/208.67.220.220#443
server=/.bitly.com/208.67.220.220#443
server=/.twimg.com/208.67.220.220#443
server=/.tinypic.com/208.67.220.220#443
server=/.yfrog.com/208.67.220.220#443
server=/.whatismyip.com/208.67.220.220#443
```

以后添加别的网站的时候，只要复制任意一行，把域名部分改下即可，其他部分不用动。

最后再网页管理界面中的设置-基本设置中的网络地址服务器设置 (DHCP)下，把最后三个钩打上。

## 配置路由器开机启动shadowsocks

在路由器管理界面中，管理-命令，在指令里输入：

```
/jffs/shadowsocks/ss-redir -c /jffs/shadowsocks/shadowsocks.json -f /var/run/ss-redir.pid
```

然后点下面的保存为启动指令。

再在指令对话框里输入下面的内容

```
#create a new chain named SHADOWSOCKS
iptables -t nat -N SHADOWSOCKS

#Redirect what you want

#Google
iptables -t nat -A SHADOWSOCKS -p tcp -d 74.125.0.0/16 -j REDIRECT --to-ports 1080
iptables -t nat -A SHADOWSOCKS -p tcp -d 173.194.0.0/16 -j REDIRECT --to-ports 1080
iptables -t nat -A SHADOWSOCKS -p tcp -d 216.58.0.0/16 -j REDIRECT --to-ports 1080

#Youtube
iptables -t nat -A SHADOWSOCKS -p tcp -d 208.117.224.0/24 -j REDIRECT --to-ports 1080
iptables -t nat -A SHADOWSOCKS -p tcp -d 209.85.128.0/24 -j REDIRECT --to-ports 1080

#Twitter
iptables -t nat -A SHADOWSOCKS -p tcp -d 199.59.148.0/24 -j REDIRECT --to-ports 1080
iptables -t nat -A SHADOWSOCKS -p tcp -d 173.252.64.0/24 -j REDIRECT --to-ports 1080

#xvideos
iptables -t nat -A SHADOWSOCKS -p tcp -d 141.0.172.0/22 -j REDIRECT --to-ports 1080
iptables -t nat -A SHADOWSOCKS -p tcp -d 111.0.0.0/8 -j REDIRECT --to-ports 1080
iptables -t nat -A SHADOWSOCKS -p tcp -d 117.0.0.0/8 -j REDIRECT --to-ports 1080

#youporn
iptables -t nat -A SHADOWSOCKS -p tcp -d 31.192.112.0/20 -j REDIRECT --to-ports 1080

#digitalocean.css
iptables -t nat -A SHADOWSOCKS -p tcp -d 103.245.222.0/24 -j REDIRECT --to-ports 1080

#wordpress
iptables -t nat -A SHADOWSOCKS -p tcp -d 66.155.0.0/17 -j REDIRECT --to-ports 1080

#what is my ip
iptables -t nat -A SHADOWSOCKS -p tcp -d 141.101.120.0/24 -j REDIRECT --to-ports 1080

#Facebook
iptables -t nat -A SHADOWSOCKS -p tcp -d 173.252.120.0/24 -j REDIRECT --to-ports 1080
iptables -t nat -A SHADOWSOCKS -p tcp -d 173.252.64.0/18 -j REDIRECT --to-ports 1080
iptables -t nat -A SHADOWSOCKS -p tcp -d 66.220.144.0/20 -j REDIRECT --to-ports 1080
iptables -t nat -A SHADOWSOCKS -p tcp -d 31.13.0.0/16 -j REDIRECT --to-ports 1080

#sourceforge
iptables -t nat -A SHADOWSOCKS -p tcp -d 216.32.0.0/14 -j REDIRECT --to-ports 1080

#zh.wikipedia
iptables -t nat -A SHADOWSOCKS -p tcp -d 78.16.0.0/14 -j REDIRECT --to-ports 1080

#gravatar
iptables -t nat -A SHADOWSOCKS -p tcp -d 192.0.64.0/18 -j REDIRECT --to-ports 1080


#Anything else should be ignore
iptables -t nat -A SHADOWSOCKS -p tcp -j RETURN

# Apply the rules
iptables -t nat -A PREROUTING -p tcp -j SHADOWSOCKS


```

保存为防火墙指令。这时路由器自动重启，之后路由器里的所有设备就应该可以翻墙了。

## 完善科学上网网站列表

路由器是如何判断哪些网站走代理，哪些网站直接访问的呢？答案就在最后的这段防火墙指令里。我们需要不断把需要翻墙的网站的服务器IP段写在里面，一旦发现有人访问这些，就会交给shadowsocks处理，从而实现科学上网。

拿youtube来说，下面这段防火墙指令里，最重要的就是根据youtube的域名，把它的服务器IP段找到并填进去。

```
#Youtube
iptables -t nat -A SHADOWSOCKS -p tcp -d 208.117.224.0/24 -j REDIRECT --to-ports 1080
iptables -t nat -A SHADOWSOCKS -p tcp -d 209.85.128.0/24 -j REDIRECT --to-ports 1080
```

那么如何根据要访问的网站的域名找到它的IP段呢？

1. 首先在cmd或终端下用nslookup 域名 这个命令得到其中一个ip。比如youtube的，命令为

   ```
   nslookup youtube.com
   ```
   
2. 得到一个ip后，在这里<http://wq.apnic.net/apnic-bin/whois.pl> 输入ip得到正确格式的IP段，例如youtube的为208.117.224.0/24

3. 某些特殊网站在apnic可能查不到，需要到https://stat.ripe.net/ 查找。

总结一下，当你发现一个网站需要翻墙才能访问时，有两部需要做。第一，在dns配置那步里的dnsmasq附加选项里添加域名；第二，找出域名对应的ip段，将下面形式的规则

```
iptables -t nat -A SHADOWSOCKS -p tcp -d IP段 -j REDIRECT --to-ports 1080
```

添加到路由器防火墙的规则里。