# mac挂载cephfs

- [mulbc/homebrew-ceph-client: Homebrew tap for ceph client libraries (github.com)](https://github.com/mulbc/homebrew-ceph-client)

- `brew install macfuse` (不确定是否必须，下次重装时测试)
- `/etc/ceph/ceph.conf`集群moniter配置
- `/etc/ceph/ceph.client.admin.keyring`集群秘钥配置
- `sudo ceph-fuse /Users/xxx/cephfs`挂载

