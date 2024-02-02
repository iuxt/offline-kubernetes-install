#!/bin/bash

source .env

if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script"
    exit 1
fi

cd init && bash init.sh && cd -
cd docker && bash install.sh && cd -
cd flannel && bash install.sh && cd -
cd kubeadm && bash install.sh && bash create_cluster.sh ${API_SERVER} && cd -
cd ingress-nginx && bash install.sh && cd -
