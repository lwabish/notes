# Centos7

## 包管理

### yum

- yum update/upgrade：升级系统版本和软件版本，不包含内核。比如centos7.7升级为7.8
- yum repolist：查看当前yum配置的源
- yum check-update：检查包更新
- yum公共配置文件：`/etc/yum.conf`（可配置代理）
- 安装指定版本：
  - yum list kubectl --showduplicates
  - yum install 名称前缀-版本.架构：例如**kubectl-1.15.12-0.x86_64**

### rpm

- rpm -ql XXX：包安装的所有文件和目录
- rpm -qa XXX：是否已安装某包

## 基础知识

- EPEL：Extra Packages for Enterprise Linux
- ELRepo：ELRepo是Enterprise Linux软件包的RPM存储库。ELRepo支持红帽企业Linux（RHEL）及其衍生产品（Scientific Linux，CentOS等）。ELRepo项目专注于硬件相关软件包，以增强使用Enterprise Linux的体验。这包括文件系统驱动程序，图形驱动程序，网络驱动程序，声音驱动程序，网络摄像头和视频驱动

## 系统管理

```bash
cat /etc/redhat-release
uname -sr
```

## 升级内核到最新的主线（mainline）

1. 启用[elrepo](http://elrepo.org/tiki/tiki-index.php)
2. 查看可用新内核：`yum --disablerepo="*" --enablerepo="elrepo-kernel" list available`

3. 安装最新的ml内核：`yum --enablerepo=elrepo-kernel install kernel-ml`

4. 更新grub配置

   - `/etc/default/grub`：`GRUB_DEFAULT=0`

   - `grub2-mkconfig -o /boot/grub2/grub.cfg && reboot`

5. 清理：

   - 查看一下要删除的包`rpm -qa | grep kernel`
   - 确认后删除`rpm -qa | grep kernel|xargs yum remove -y`

## 升级内核小版本

`yum update kernel`

## 内核参数修改

临时：`echo xxx>/proc/xxx`立即生效

永久：`vim /etc/sysctl.conf`  重启或者`sysctl  -p`后生效