# offline-kubernetes-install

完全离线的情况下, 安装k8s集群, 基于CentOS7, k8s 1.21.10 版本, 容器运行时 是docker

| 脚本               | 说明                                   |
| ------------------ | -------------------------------------- |
| 0-kernel_5.4.sh    | 可选, 安装5.4内核                      |
| 0-config.sh        | 修改里面的配置, 然后执行               |
| 0-download.sh      | 下载离线包, 支持断点续传               |
| 1-init.sh          | 初始化配置, 所有节点都需要执行         |
| 2-create_k8s.sh    | 创建集群, 只需要在一台master上执行即可 |
| 3-nginx_ingress.sh | 安装nginx-ingress                      |
