# offline-kubernetes-install
完全离线的情况下, 安装k8s集群, 基于 CentOS7, k8s 1.21.10 版本, 容器运行时 是docker， 安装工具是kubeadm， 全部采用容器化或者rpm包的形式部署， 坚决不使用二进制。

## 系统要求

centos 7 最小化安装, 所有节点之间做好 ssh 免密并成功登录一次

提前执行 download.sh 下载离线包才可离线安装

## 文件介绍


| 文件               | 说明                                   |
| ------------------ | -------------------------------------- |
| kernel_5.4    | 可选安装, 安装5.4内核                      |
| ingress-nginx        | 可选安装, ingress-nginx 集群入口               |
| download.sh      | 下载离线包, 支持断点续传               |
| kubeadm          |  安装 kubeadm 和初始化集群        |
|temp|下载的临时目录|
|keepalived|keepalived + LVS 负载均衡, 提供 master 高可用|
|flannel|网络插件|
|init|机器初始化配置|


事先执行`download.sh`下载好离线包
5.4内核看个人需求是否执行, 如需更新， 执行 `cd kernel_5.4 && bash install.sh`

## 单节点k8s部署

1. 执行 download.sh 下载需要的包
2. 修改 single.env 里面的apiserver地址, 单节点就填自己的 ip
3. 执行 single.sh 即可创建单 master k8s

## 集群部署

前提条件： 代码克隆到本地， 确保 当前机器 可以免密访问其他节点

执行 download.sh 下载需要的包

修改 cluster.env 配置

执行 cluster.sh 进行初始化

