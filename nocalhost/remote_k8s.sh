
# 远程k8s使用指南

[使用方式](https://nocalhost.dev/docs/quick-start)


# 配置方式
1. 查看 `~/.kube/config`中的连通方式
```
kubectl config view --raw --flattern
```

2. 将令牌copy到本机环境( 由于是采用`minikube`部署)
```
scp -r root@eof.com:/root/.minikube/\{ca.crt,client.crt,client.key\} ~/.minikube/
scp -r root@eof.com:/root/.minikube/ ~/.minikube/
```

3. 变更 `config` 文件内容

```
apiVersion: v1
clusters:
- cluster:
    certificate-authority: /Users/houshuai/.minikube/ca.crt     # 配置到正确地址
    extensions:
    - extension:
        last-update: Sat, 29 Jan 2022 17:13:03 CST
        provider: minikube.sigs.k8s.io
        version: v1.25.1
      name: cluster_info
    server: https://127.0.0.1:8443                              # 需要变更为可访问到地址
  name: minikube
contexts:
- context:
    cluster: minikube
    extensions:
    - extension:
        last-update: Sat, 29 Jan 2022 17:13:03 CST
        provider: minikube.sigs.k8s.io
        version: v1.25.1
      name: context_info
    namespace: default
    user: minikube
  name: minikube
current-context: minikube
kind: Config
preferences: {}
users:
- name: minikube
  user:
    client-certificate: /Users/houshuai/.minikube/client.crt    # 配置到正确地址
    client-key: /Users/houshuai/.minikube/client.key            # 配置到正确地址

```

**注意：** 由于不具备对外暴露 因此采用ssh 代理方式(local 8443 <-- remote 8848)
```
ssh -fN -g -L 8443:192.168.49.2:8443 -o serveraliveinterval=60 root@eof.com
```

