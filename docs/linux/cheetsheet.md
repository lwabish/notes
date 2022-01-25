# Cheetsheet

```bash
# 隧道
ssh -fCPN -L 本地监听端口:跳板机网络真实目标:真实目标端口 ssh用户@ssh目标 -p ssh端口
# 例：
ssh -fCPN -L 12345:192.168.130.180:59882 xxxx@172.16.245.11 -p 41200


# 回溯历史操作
# 1.找出大概范围,得到history编号$line
history|grep $keyWord
# 2.精确显示附近操作
# 目标行之后
history|more +$line
history|more -$line 

# 后台运行
nohup $command >> $logFile 2>&1 &
```

