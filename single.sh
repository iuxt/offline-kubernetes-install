#!/bin/bash
set -euo pipefail

source single.env

if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script"
    exit 1
fi

cd scripts
./init.sh
./create_cluster.sh
./nginx_ingress.sh
