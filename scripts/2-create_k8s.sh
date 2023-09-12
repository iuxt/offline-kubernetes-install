#!/bin/bash
set -euo pipefail

source .env


apiserver="__API_SERVER__"


sudo kubeadm init \
    --kubernetes-version 1.21.10 \
    --control-plane-endpoint "${apiserver}:6443" \
    --upload-certs \
    --service-cidr=10.96.0.0/12 \
    --pod-network-cidr=10.244.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

if [ $(grep -c "kubectl completion bash" /root/.bashrc) -eq 0 ];then
cat <<EOF | sudo tee -a /root/.bashrc
source /usr/share/bash-completion/bash_completion
source <(kubectl completion bash)
EOF
fi

cd ../flannel && bash install.sh && cd -
