# offline-kubernetes-install
完全离线的情况下, 安装k8s集群, 基于 CentOS7, k8s 1.21.10 版本, 容器运行时 是docker， 安装工具是kubeadm， 全部采用容器化或者rpm包的形式部署， 坚决不使用二进制。

## 系统要求

centos 7 最小化安装, 所有节点之间做好 ssh 免密并成功登录一次

提前执行scripts/download.sh下载离线包才可离线安装

## 文件介绍


| 脚本               | 说明                                   |
| ------------------ | -------------------------------------- |
| kernel_5.4.sh    | 可选, 安装5.4内核                      |
| 0-config.sh        | 修改里面的配置, 然后执行               |
| download.sh      | 下载离线包, 支持断点续传               |
| init.sh          | 初始化配置, 所有节点都需要执行         |
| create_cluster.sh    | 创建集群, 只需要在一台master上执行即可 |
| nginx_ingress.sh | 安装nginx-ingress                      |

事先执行`download.sh`下载好离线包到`master1`上面
5.4内核看个人需求是否执行, 如需更新， 执行 `scripts/kernel_5.4.sh`

## 单节点k8s部署

1. 执行 scripts/download.sh 下载需要的包
2. 修改 single.env 里面的apiserver地址
3. 执行 single.sh 即可创建集群

## 集群部署

前提条件： 代码克隆到 master1 上面， 确保 master1 可以免密访问其他节点

修改 cluster.env 配置

执行 cluster.sh 进行初始化

