# Kubectl

```shell
alias k=kubectl

# 命名空间级别的image pull secret
k create secret docker-registry tcr \
	--docker-server=${registry} \
	--docker-username=${username} \
	--docker-password=${password}

k patch -n lens-metrics daemonsets node-exporter \
	-p '{"spec": {"template": {"spec": {"nodeSelector": {"non-existing": "true"}}}}}'
```



