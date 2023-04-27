#!/bin/bash

cd temp/
curl -OL -C - https://github.com/iuxt/offline-kubernetes-install/releases/download/docker-ce-20.10.23-3.el7.x86_64/docker-ce-20.10.tar.gz
curl -OL -C - https://github.com/iuxt/offline-kubernetes-install/releases/download/flannel/flannel.tar.gz
curl -OL -C - https://github.com/iuxt/offline-kubernetes-install/releases/download/ingress-nginx/ingress-nginx.tar.gz
# curl -OL -C - https://github.com/iuxt/offline-kubernetes-install/releases/download/kernel_5.4/kernel_5.4.tar.gz
curl -OL -C - https://github.com/iuxt/offline-kubernetes-install/releases/download/kubeadm_images/kubeadm_images.tar.gz
curl -OL -C - https://github.com/iuxt/offline-kubernetes-install/releases/download/kubeadm_rpms/kubeadm_rpms.tar.gz

tar xf docker-ce-20.10.tar.gz -C ../docker/
tar xf flannel.tar.gz -C ../flannel/
tar xf ingress-nginx.tar.gz -C ../ingress-nginx/
# tar xf kernel_5.4.tar.gz -C ../kernel_5.4/
tar xf kubeadm_images.tar.gz -C ../kubeadm/
tar xf kubeadm_rpms.tar.gz -C ../kubeadm/
