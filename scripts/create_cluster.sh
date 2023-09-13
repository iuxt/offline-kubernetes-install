#!/bin/bash
set -euo pipefail

# 初始化集群
sudo kubeadm init \
    --kubernetes-version 1.21.10 \
    --control-plane-endpoint "$1:6443" \
    --upload-certs \
    --service-cidr=10.96.0.0/12 \
    --pod-network-cidr=10.244.0.0/16

# 配置kubeconfig
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# kubectl自动补全
if [ $(grep -c "kubectl completion bash" /root/.bashrc) -eq 0 ];then
cat <<EOF | sudo tee -a /root/.bashrc
source /usr/share/bash-completion/bash_completion
source <(kubectl completion bash)
EOF
fi

# 安装flannel
cd ../flannel && bash install.sh && cd -
