# maven

## deploy时透明代理问题

运行mvn deploy前按照网上搜的教程配置好了目标仓库和认证信息，但是报错

```
[ERROR] Failed to execute goal org.apache.maven.plugins:maven-deploy-plugin:2.8.2:deploy (default-deploy) on project XXXXXX: Failed to deploy artifacts: Could not transfer artifact YYYYYYY:pom:0.6-20220119.073740-6 from/to releases (http://172.16.236.248:8081/repository/maven-snapshots/): 172.16.236.248:8081 failed to respond -> [Help 1]
```

加上-e或者-X选项开启详细日志，可以看到异常栈里包含和http response相关的类，比如NoHttpResponseException。就在百思不得其解时想到可能和透明代理有关系。

关掉mellow后再deploy果然ok了。

**使用了mellow这类透明代理后，即使nexus使用ip连接，也会干扰到mvn deploy时和nexus服务器的http交互**