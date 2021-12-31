# Containerd

## insecure registry

```toml
# vim /etc/containerd/config.toml

[plugins."io.containerd.grpc.v1.cri".registry]
	[plugins."io.containerd.grpc.v1.cri".registry.mirrors]
  	[plugins."io.containerd.grpc.v1.cri".registry.mirrors."172.16.236.242:60020"]
  		endpoint = ["http://172.16.236.242:60020", "https://"]
  		
 	[plugins."io.containerd.grpc.v1.cri".registry.auths]
    [plugins."io.containerd.grpc.v1.cri".registry.auths."http://172.16.236.242:60020"]
      username = "admin"
      password = "Harbor12345"
```

`systemctl restart containerd`
