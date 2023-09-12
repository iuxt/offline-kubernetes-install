#!/bin/bash
set -euo pipefail

source single.env

if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script"
    exit 1
fi

cd scripts
./1-init.sh
sed -e "s/^apiserver=.*/apiserver=${API_SERVER}/g" -i 2-create_k8s.sh
./2-create_k8s.sh
./3-nginx_ingress.sh
