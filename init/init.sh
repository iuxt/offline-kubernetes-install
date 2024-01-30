#!/bin/bash
set -euo pipefail

if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script"
    exit 1
fi

systemctl disable --now firewalld
setenforce 0
sed -i "s/^SELINUX=.*/SELINUX=disabled/g" /etc/selinux/config



cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

# 关闭swap
swapoff -a
sed -i 's/.*swap.*/#&/' /etc/fstab

yum install -y ./*.rpm

cd ../docker && bash ./install.sh && cd -
cd ../kubeadm && bash ./install.sh && cd -
cd ../flannel && bash install.sh

