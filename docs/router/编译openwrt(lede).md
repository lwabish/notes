# 编译Lede版本Openwrt

## ubuntu本地

### 编译环境

Ubuntu 20LTS 桌面版

非root普通用户

根据lede主页apt install编译需要的包

### 首次编译

- 主流程参照lede主页的步骤，有一处需要修改：clone 完代码，进行下一步前，先开启ssr plus

  > 编辑`feeds.conf.default`，把helloworld的注释取消掉
  >
  > 如果没有，加入下面两行
  >
  > src-git helloworld https://github.com/fw876/helloworld
  > src-git passwall https://github.com/xiaorouji/openwrt-passwall

- menu config中，网件r7800在Qualcomm Atheros IPQ8065下;linksys wrt32x在Marvell EBU Armada 38X下

### 后续更新编译

- 参考lede github流程即可

## mac容器编译

1. mac下需要先建立case sensitive volume，在该volume下操作后续流程
1. 有权限问题，不再使用该方法

## github action【推荐】

[lwabish/lede: Lean's OpenWrt source (github.com)](https://github.com/lwabish/lede)

新建release即可触发编译

目前默认的config中型号是NETGEAR r7800

如果需要修改型号，需要修改config文件

## 参考

[coolsnowwolf/lede: Lean's OpenWrt source (github.com)](https://github.com/coolsnowwolf/lede)

[OpenWrt Wiki Netgear R7800 (Nighthawk X4S AC2600)](https://openwrt.org/toh/netgear/r7800)

[OpenWrt Wiki Techdata: Linksys WRT32X v1 (venom)](https://openwrt.org/toh/hwdata/linksys/linksys_wrt32x_v1_venom)

[在 macOS 内使用大小写敏感的 APFS 卷存储代码 | 计算机科学论坛 (learnku.com)](https://learnku.com/articles/24422)

[KFERMercer/OpenWrt-CI: OpenWrt CI 在线集成自动编译环境 (github.com)](https://github.com/KFERMercer/OpenWrt-CI)
