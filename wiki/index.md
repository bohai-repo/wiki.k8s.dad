# 简单概览

## 常用工具

**记录本站提供的工具**

### 故障排查

#### dnsutils

支持ping、nslookup等常用网络层面需要的命令

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

### 常用工具


```shell
# argocd-cli
wget https://init.ac/files/argocd -P /usr/local/bin/ && chmod +x /usr/local/bin/argocd

# kustomize-cli
wget https://init.ac/files/kustomize -P /usr/local/bin/ && chmod +x /usr/local/bin/kustomize

# kubectl-node_shell
# 一键登录k8s节点
wget https://init.ac/files/kubectl-node_shell -P /usr/local/bin/ && chmod +x /usr/local/bin/kubectl-node_shell
```

## 站点描述

联系邮箱：admin@init.ac  
本站地址：https://wiki.k8s.dad

## 致谢

感谢伟大的MKdocs以及Github、Cloudflare提供代码托管&自动化部署

