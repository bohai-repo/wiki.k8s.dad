# Helm

Kubernetes 包管理工具

Helm 可以帮助我们管理 Kubernetes 应用程序 - Helm Charts 可以定义、安装和升级复杂的 Kubernetes 应用程序，Charts 包很容易创建、版本管理、分享和分布。Helm 对于 Kubernetes 来说就相当于 yum 对于 Centos 来说，如果没有 yum 的话，我们在 Centos 下面要安装一些应用程序是极度麻烦的，同样的，对于越来越复杂的 Kubernetes 应用程序来说，如果单纯依靠我们去手动维护应用程序的 YAML 资源清单文件来说，成本也是巨大的。接下来我们就来了解了 Helm 的使用方法。

## 安装

首先当然需要一个可用的 Kubernetes 集群，然后在我们使用 Helm 的节点上已经配置好可以通过 kubectl 访问集群，因为 Helm 其实就是读取的 kubeconfig 文件来访问集群的。

由于 Helm V2 版本必须在 Kubernetes 集群中安装一个 Tiller 服务进行通信，这样大大降低了其安全性和可用性，所以在 V3 版本中移除了服务端，采用了通用的 Kubernetes CRD 资源来进行管理，这样就只需要连接上 Kubernetes 即可，而且 V3 版本已经发布了稳定版，所以我们这里来安装最新的 v3.0.1 版本，软件包下载地址为：https://github.com/helm/helm/releases，我们可以根据自己的节点选择合适的包，比如我这里是 Mac，就下载 MacOS amd64 的版本。

下载到本地解压后，将 helm 二进制包文件移动到任意的 PATH 路径下即可：

```bash
$ helm version
version.BuildInfo{Version:"v3.0.1", GitCommit:"7c22ef9ce89e0ebeb7125ba2ebf7d421f3e82ffa", GitTreeState:"clean", GoVersion:"go1.13.4"}
```

看到上面的版本信息证明已经成功了。

一旦 Helm 客户端准备成功后，我们就可以添加一个 chart 仓库，当然最常用的就是官方的 Helm stable charts 仓库，但是由于官方的 charts 仓库地址需要科学上网，我们可以使用微软的 charts 仓库代替：

```bash
$ helm repo add stable http://mirror.azure.cn/kubernetes/charts/
$ helm repo list
NAME            URL
stable          http://mirror.azure.cn/kubernetes/charts/
```

安装完成后可以用 search 命令来搜索可以安装的 chart 包：

```bash
$ helm search repo stable
NAME                                    CHART VERSION   APP VERSION                     DESCRIPTION
stable/acs-engine-autoscaler            2.2.2           2.1.1                           DEPRECATED Scales worker nodes within agent pools
stable/aerospike                        0.3.1           v4.5.0.5                        A Helm chart for Aerospike in Kubernetes
stable/airflow                          5.2.1           1.10.4                          Airflow is a platform to programmatically autho...
stable/ambassador                       5.1.0           0.85.0                          A Helm chart for Datawire Ambassador
stable/anchore-engine                   1.3.7           0.5.2                           Anchore container analysis and policy evaluatio...
stable/apm-server                       2.1.5           7.0.0                           The server receives data from the Elastic APM a...
......
```

## 示例

为了安装一个 chart 包，我们可以使用 `helm install` 命令，Helm 有多种方法来找到和安装 chart 包，但是最简单的方法当然是使用官方的 `stable` 这个仓库直接安装：

首先从仓库中将可用的 charts 信息同步到本地，可以确保我们获取到最新的 charts 列表：

```bash
$ helm repo update
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈ Happy Helming!⎈
```

比如我们现在安装一个 `mysql` 应用：

```bash
$ helm install stable/mysql --generate-name
NAME: mysql-1575619811
LAST DEPLOYED: Fri Dec  6 16:10:14 2019
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
MySQL can be accessed via port 3306 on the following DNS name from within your cluster:
mysql-1575619811.default.svc.cluster.local
......
```

我们可以看到 `stable/mysql` 这个 chart 已经安装成功了，我们将安装成功的这个应用叫做一个 `release`，由于我们在安装的时候指定了`--generate-name `参数，所以生成的 release 名称是随机生成的，名为 `mysql-1575619811`。我们可以用下面的命令来查看 release 安装以后对应的 Kubernetes 资源的状态：

```bash
$ kubectl get all -l release=mysql-1575619811
NAME                                    READY   STATUS    RESTARTS   AGE
pod/mysql-1575619811-8479b5b796-dgggz   0/1     Pending   0          27m

NAME                       TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
service/mysql-1575619811   ClusterIP   10.106.141.228   <none>        3306/TCP   27m

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/mysql-1575619811   0/1     1            0           27m

NAME                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/mysql-1575619811-8479b5b796   1         1         0       27m
```

我们也可以 `helm show chart` 命令来了解 MySQL 这个 chart 包的一些特性：

```bash
$ helm show chart stable/mysql
......
```

如果想要了解更多信息，可以用 helm show all 命令：

```bash
$ helm show all stable/mysql
......
```

如果需要删除这个 release，也很简单，只需要使用 helm uninstall 命令即可：

```bash
$ helm uninstall mysql-1575619811
release "mysql-1575619811" uninstalled
$ kubectl get all -l release=mysql-1575619811
No resources found.
$ helm status mysql-1575619811
Error: release: not found
```

`uninstall` 命令会从 Kubernetes 中删除 release，也会删除与 release 相关的所有 Kubernetes 资源以及 release 历史记录。也可以在删除的时候使用` --keep-history` 参数，则会保留 release 的历史记录，可以获取该 release 的状态就是 `UNINSTALLED`，而不是找不到 release了：

```bash
$ helm uninstall mysql-1575619811 --keep-history
release "mysql-1575619811" uninstalled
$ helm status mysql-1575619811
helm status mysql-1575619811
NAME: mysql-1575619811
LAST DEPLOYED: Fri Dec  6 16:47:14 2019
NAMESPACE: default
STATUS: uninstalled
...
$ helm ls -a
NAME                NAMESPACE   REVISION    UPDATED                                 STATUS      CHART       APP VERSION
mysql-1575619811    default     1           2019-12-06 16:47:14.415214 +0800 CST    uninstalled mysql-1.5.0 5.7.27
```

因为 Helm 会在删除 release 后跟踪你的 release，所以你可以审查历史甚至取消删除 release（使用 `helm rollback` 命令）。

