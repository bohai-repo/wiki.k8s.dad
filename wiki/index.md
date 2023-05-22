# 简单概览

## 技巧&工具

!!! note "记录实用技巧"

dnsutils

支持常用网络层面需要的命令

```shell
$ cat dnsutils.yaml
apiVersion: v1
kind: Pod
metadata:
  name: dnsutils
spec:
  containers:
  - name: dnsutils
    image: registry.cn-hangzhou.aliyuncs.com/bohai_repo/dnsutils:1.3
    imagePullPolicy: IfNotPresent
    command: ["sleep","36000"]
```

```shell
kubectl apply -n kube-system -f dnsutils.yaml
kubectl exec -n kube-system dnsutils
```

kubectl cli插件

```shell
# argocd-cli
wget https://init.ac/files/argocd -P /usr/local/bin/ && chmod +x /usr/local/bin/argocd

# kustomize-cli
wget https://init.ac/files/kustomize -P /usr/local/bin/ && chmod +x /usr/local/bin/kustomize

# kubectl-node_shell
wget https://init.ac/files/kubectl-node_shell -P /usr/local/bin/ && chmod +x /usr/local/bin/kubectl-node_shell
```

## 站点描述

联系邮箱：admin@init.ac  
本站地址：https://wiki.k8s.dad

## 致谢

感谢伟大的Mkdocs以及Github、Cloudflare提供代码托管&自动化部署

## 贡献文档

欢迎fork 本仓库 [wiki.k8s.dad](https://github.com/bohai-repo/wiki.k8s.dad) 提交PR上传文档
