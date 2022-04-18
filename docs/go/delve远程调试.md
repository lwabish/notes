# goland/idea远程调试go程序

## 基本原理

在开发过程中可能遇到以下两类问题：

1. 本地开发完成后，在其他环境运行时程序表现和预期不一致
2. 本地难以调试，比如kubelet

为了解决这些问题，可以结合使用delve和jetbrain家的IDE，方便地在远程环境运行程序，同时在本地打断点调试。

[delve](https://github.com/go-delve/delve)类似于一个cs架构的中间人，在远程环境托管目标程序的二进制执行，同时启动server端；本地的IDE指定delve远程服务的ip:port，即可将远程环境的执行和本地的代码链接起来，完成远程调试。

## 代码同步

为了方便本地代码在远程环境的快速执行，可以配置goland的代码同步：tools-deployment-configuration-sftp。配置目标环境的ssh信息以及同步目录位置以后，再勾选tools-deployment-automatic upload，每次本地代码修改，将会自动同步到远程目录。

## 远程环境准备

1. 安装go：直接下载二进制，解压移动到合适的位置，配置PATH、GOROOT、GOPATH
2. 安装delve：直接克隆代码，make install即可

## 启动远程环境的delve服务端

远程环境无公网访问权限：

进入代码同步的目录，手动build二进制：`go build -gcflags "all=-N -l" main.go`

然后启动delve服务端，由delve托管待调试二进制程序的运行

`dlv --listen=:2345 --headless=true --api-version=2 --accept-multiclient exec ./main`

注意：如果目标二进制程序有command以及subcommand和flag如何加入dlv命令中：

`dlv --listen=:2345 --headless=true --api-version=2 --accept-multiclient exec ./main -- command subcommand -f "xxx" ` 

从--往后的内容将作为目标程序的command和flag，而不再是dlv的命令行内容。

如果远程环境有公网，可使用dlv进行程序的编译，我使用的时候发现需要调用go get下载依赖，所以未进行后续测试。

`dlv debug --headless --listen=:2345 --api-version=2 --accept-multiclient`

## 本地断点调试

idea/goland的Run/Debug配置中，新增一个go remote配置，指定host为上步远程环境的ip，port保持默认即可。然后启动该调试即可。

此时远程的目标程序会运行，且本地如果打了断点，可正常被拦截到。