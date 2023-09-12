#!/bin/bash
set -euo pipefail

source cluster.env

if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script"
    exit 1
fi

cd scripts
./init.sh
sed -e "s/^apiserver=.*/apiserver=${VIP}/g" -i create_cluster.sh
./create_cluster.sh
./nginx_ingress.sh
