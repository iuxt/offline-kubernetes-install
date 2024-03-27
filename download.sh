#!/bin/bash
set -euo pipefail

source .env

cd temp/

if [ x${USE_CHINA_MIRROR} == "xyes" ]; then
    curl -OL -C - https://git.babudiu.com/iuxt/offline-kubernetes-install/releases/download/docker-ce/docker-ce-20.10.tar.gz
    curl -OL -C - https://git.babudiu.com/iuxt/offline-kubernetes-install/releases/download/flannel/flannel.tar.gz
    curl -OL -C - https://git.babudiu.com/iuxt/offline-kubernetes-install/releases/download/ingress-nginx/ingress-nginx.tar.gz
    curl -OL -C - https://git.babudiu.com/iuxt/offline-kubernetes-install/releases/download/kernel_5.4/kernel_5.4.tar.gz
    curl -OL -C - https://git.babudiu.com/iuxt/offline-kubernetes-install/releases/download/kubeadm/kubeadm_images.tar.gz
    curl -OL -C - https://git.babudiu.com/iuxt/offline-kubernetes-install/releases/download/kubeadm/kubeadm_rpms.tar.gz
    curl -OL -C - https://git.babudiu.com/iuxt/offline-kubernetes-install/releases/download/keepalived/keepalived.tar.gz
    curl -OL -C - https://git.babudiu.com/iuxt/offline-kubernetes-install/releases/download/rpms/bash-completion-2.1-8.el7.noarch.rpm
    curl -OL -C - https://git.babudiu.com/iuxt/offline-kubernetes-install/releases/download/rpms/rsync-3.1.2-12.el7_9.x86_64.rpm
else
    curl -OL -C - https://github.com/iuxt/offline-kubernetes-install/releases/download/docker-ce-20.10.23-3.el7.x86_64/docker-ce-20.10.tar.gz
    curl -OL -C - https://github.com/iuxt/offline-kubernetes-install/releases/download/flannel/flannel.tar.gz
    curl -OL -C - https://github.com/iuxt/offline-kubernetes-install/releases/download/ingress-nginx/ingress-nginx.tar.gz
    curl -OL -C - https://github.com/iuxt/offline-kubernetes-install/releases/download/kernel_5.4/kernel_5.4.tar.gz
    curl -OL -C - https://github.com/iuxt/offline-kubernetes-install/releases/download/kubeadm_images/kubeadm_images.tar.gz
    curl -OL -C - https://github.com/iuxt/offline-kubernetes-install/releases/download/kubeadm_rpms/kubeadm_rpms.tar.gz
    curl -OL -C - https://github.com/iuxt/offline-kubernetes-install/releases/download/keepalived/keepalived.tar.gz
    curl -OL -C - https://github.com/iuxt/offline-kubernetes-install/releases/download/bash-completion/bash-completion-2.1-8.el7.noarch.rpm
    curl -OL -C - https://github.com/iuxt/offline-kubernetes-install/releases/download/rsync/rsync-3.1.2-12.el7_9.x86_64.rpm
fi


md5sum -c md5.sum

tar xf docker-ce-20.10.tar.gz -C ../docker/
tar xf flannel.tar.gz -C ../flannel/
tar xf ingress-nginx.tar.gz -C ../ingress-nginx/
tar xf kernel_5.4.tar.gz -C ../kernel_5.4/
tar xf kubeadm_images.tar.gz -C ../kubeadm/
tar xf kubeadm_rpms.tar.gz -C ../kubeadm/
tar xf keepalived.tar.gz -C ../keepalived/
cp bash-completion-2.1-8.el7.noarch.rpm ../kubeadm/
cp rsync-3.1.2-12.el7_9.x86_64.rpm ../init/
