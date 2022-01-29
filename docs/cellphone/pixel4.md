# Google Pixel4

## 操作前需备份

1. 照片
2. 微信聊天记录
3. bluecoins数据
4. 微软二次验证

## 全新刷机

1. [下载固件](https://developers.google.com/android/images#flame)
1. 电脑`brew install android-platform-tools`，手机开usb调试，开机连接电脑，`adb devices`验证无误
1. `adb reboot bootloader`
3. 解压固件，运行`./flash-all`
3. 如果不需要root，到此即可停止
4. 拷贝magisk manager，出厂镜像里的boot.img到手机
5. 安装magisk manager，手机联网，打开magisk manager，安装magisk，修补镜像
6. 从download目录把magisk_patched.img拷到电脑
   1. 拔线，关机，音量下开机，插线
   2. `fastboot flash boot magisk_patched.img`
   3. `fastboot reboot`
7. 进magisk，刷电信volte

## xposed-太极方案

1. 安taichi magisk模块，安太极apk
2. 微x：太极里直接下载
3. 刷脸支付：安fingerface（play store已购买）、指纹支付（太极模块下载页面）
4. ~~刷其他magisk模块：雷达功能：刷enablesoli~~

## xposed-edxposed方案

[ElderDrivers/EdXposed: Elder driver Xposed Framework. (github.com)](https://github.com/ElderDrivers/EdXposed)

## OTA升级

![OTA](https://cdn.wubw.fun/typora/210629-113611-OTA.jpg)

1. 退出google，不一定是必须的
2. 下[factory镜像](https://developers.google.com/android/images#flame)，解压zip包，拷贝boot.img到手机，magisk中卸载，还原原厂镜像，安装，修补，用magisk patch boot.img，然后将patch过的img拷到电脑
3. 重启进入刷机模式
4. 删除-w，flash all
5. fastboot 刷magisk_patched
6. 删除magisk中的电信，重刷
7. 登陆google