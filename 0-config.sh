#!/bin/bash
set -euo pipefail

source .env

sed -e "s/__MASTER1__/${MASTER1}/g" \
    -e "s/__MASTER2__/${MASTER2}/g" \
    -e "s/__MASTER3__/${MASTER3}/g" \
    -e "s/__VIP__/${VIP}/g" \
    -i keepalived/*.conf

sed -e "s/__API_SERVER__/${VIP}/g" -i 2-create_k8s.sh