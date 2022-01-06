# Ansible

```shell
alias a='ansible'
```

## 模块

### 连通性测试

```bash
ansible all -m ping
```

### shell命令

```bash
ansible all -m shell -a "w"
```

### 文件系统操作

```bash
# 创建目录
ansible all -m file -a "dest=/data/log/kubernetes state=directory"

# 复制文件，注意：src是指执行ansible的机器上的文件路径
ansible all -m copy -a "src=/opt/images/pause-amd64.tar dest=/root/"
```

### 文件内容编辑

```shell
# 增加新行
ansible all -m lineinfile -a "dest=/etc/chrony.conf line='allow 192.168.1.0/24'"

# 正则匹配替换
a all -m lineinfile -a "path=/etc/sysconfig/network-scripts/ifcfg-eth0 regexp='^GATEWAY=' line=GATEWAY=172.16.236.6"
```

### yum包管理

```shell
# 安装
ansible all -m yum -a "name=net-tools state=present"
```

### 定时任务

```shell
# 新增
ansible etcd -m cron -a "name='backup-etcd' job='/usr/bin/sh /k8s/etcd/bin/backup-etcd.sh' minute=30 hour=4"
```

## 	预配置

### host配置

- `sudo vim /etc/ansible/hosts`

- 关键要素

  ```ini
  [组名]
  domain ansible_user=x ansible_port=22 ansible_ssh_pass="yyyyy"
  ip
  domain[1:3]
  
  [组名:vars]
  ansible_user=x
  ansible_port=22
  ansible_ssh_pass=yyy
  ```

### 批量信任ssh公钥指纹	

```bash
cat << EOF > trust-ssh-fingerprints
#!/usr/bin/env ansible-playbook
---
- name: accept ssh fingerprint automatically for the first time
  hosts: '{{ hosts }}'
  connection: local
  gather_facts: False

  tasks:
    - name: "check if known_hosts contains server's fingerprint"
      command: ssh-keygen -F {{ inventory_hostname }}
      register: keygen
      failed_when: keygen.stderr != ''
      changed_when: False

    - name: fetch remote ssh key
      command: ssh-keyscan -T5 {{ inventory_hostname }}
      register: keyscan
      failed_when: keyscan.rc != 0 or keyscan.stdout == ''
      changed_when: False
      when: keygen.rc == 1

    - name: add ssh-key to local known_hosts
      lineinfile:
        name: ~/.ssh/known_hosts
        create: yes
        line: "{{ item }}"
      when: keygen.rc == 1
      with_items: '{{ keyscan.stdout_lines|default([]) }}'
EOF

ansible-playbook trust-ssh-fingerprints -e "hosts=主机组名称"
```

### 批量配置ssh免密登陆

```bash
# 在ansible hosts配置里要加上ansible_ssh_pass ansible_user=xxxxxxx
# 注意修改里面的三处用户名
cat << EOF > push-ssh-keys
  - hosts: '{{ hosts }}'
    # 本地用户
    user: xxxxxxxxx
    tasks:
     - name: ssh-copy
     # 这里的user是ssh-copy-id 里的user，file的路径是公钥的路径
       authorized_key: user=yyyyyyyy key="{{ lookup('file', '/Users/xxxxxxxxx/.ssh/id_rsa.pub') }}"
       tags:
         - sshkey
EOF

ansible-playbook push-ssh-keys -e "hosts=主机组名称"
```

### 指定部分主机

把命令中的主机组直接替换为主机目标即可

```bash
ansible xxx,yyy -m ping
```

## 参考

[How to build your inventory — Ansible Documentation](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html)