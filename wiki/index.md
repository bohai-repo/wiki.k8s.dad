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
kubectl exec -it -n kube-system dnsutils sh
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

文件拷贝工具

```shell
// 某些情况下或者不想敲复杂的kubectl指令，可以选择使用这里的文件拷贝工具来方便我们复制文件

使用：
curl -4s https://transfer.init.ac/init/file.sh | bash -s 本地文件路径

原理：
临时将文件上传至文件服务器(保留天数、允许下载数可控)进行保留，上传成功后返回文件地址，例如：
[INFO] /bin/ping transfer success;Total time: 3 seconds. file url: https://transfer.init.ac/SwGtVb/ping

链接：https://transfer.init.ac/SwGtVb/ping 即是最终文件的下载地址，可以使用任何工具进行下载、访问；

默认文件保留天数为一天、只允许下载一次；可通过环境变量来配置：

# 开启文件管理控制
export save_file_control=true
# 最大保存天数
export max_save_days=3
# 最大下载次数
export max_download_nums=10

也可以禁用控制，无限期、无限量保存文件
export save_file_control=false
```
Docker hub

Docker官方的hub地址已经被国内ban，为了提供类似的服务，本站镜像了hub地址：https://hub.k8s.dad  （局限于域名并非官方，固不能使用登录&注册功能）

## 站点描述

联系邮箱：admin@init.ac  
本站地址：https://wiki.k8s.dad

## 致谢

感谢伟大的Mkdocs以及Github、Cloudflare提供代码托管&自动化部署

## 贡献文档

欢迎fork 本仓库 [wiki.k8s.dad](https://github.com/bohai-repo/wiki.k8s.dad) 提交PR上传文档
