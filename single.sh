#!/bin/bash

source single.env

if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script"
    exit 1
fi

./init/init.sh
./kubeadm/create_cluster.sh ${API_SERVER}
./ingress-nginx/install.sh
