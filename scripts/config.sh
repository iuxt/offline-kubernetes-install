#!/bin/bash
set -euo pipefail

source .env

# 生成keepalived配置文件
sed -e "s/__MASTER1__/${MASTER1}/g" \
    -e "s/__MASTER2__/${MASTER2}/g" \
    -e "s/__MASTER3__/${MASTER3}/g" \
    -e "s/__VIP__/${VIP}/g" \
    -i keepalived/*.conf

# 修改脚本内VIP
sed -e "s/__API_SERVER__/${VIP}/g" -i create_cluster.sh

