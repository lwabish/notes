## 新建windows vm表单

usb控制器：3.0 qemu

磁盘virtio：settings- vm manager-下载virtio驱动

vnc改独显

声卡选独显

网卡virtio

## 修订xml

找到独显相关的pci配置，包括显示和声音，覆盖为以下的值。

```xml
<hostdev mode='subsystem' type='pci' managed='yes'>
      <driver name='vfio'/>
      <source>
        <address domain='0x0000' bus='0x01' slot='0x00' function='0x0'/>
      </source>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x05' function='0x0' multifunction='on'/>
    </hostdev>

<hostdev mode='subsystem' type='pci' managed='yes'>
  <driver name='vfio'/>
  <source>
    <address domain='0x0000' bus='0x01' slot='0x00' function='0x1'/>
  </source>
  <address type='pci' domain='0x0000' bus='0x00' slot='0x05' function='0x1'/>
</hostdev>
```

修改完后update，不要回表单模式。

## 启动vm开始安装

加载virtio驱动，amd64位，w10目录下。

## 驱动安装

1. 网卡驱动：virtio光驱目录下的64位installer

## 参考

[UnRAID 6/Getting Started - unRAID](https://wiki.unraid.net/UnRAID_6/Getting_Started)

https://www.bilibili.com/video/BV1Ya4y1L7hM

