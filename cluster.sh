#!/bin/bash
set -euo pipefail

source cluster.env

if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script"
    exit 1
fi


# 生成keepalived配置文件
git 
sed -e "s/__MASTER1__/${MASTER1}/g" \
    -e "s/__MASTER2__/${MASTER2}/g" \
    -e "s/__MASTER3__/${MASTER3}/g" \
    -e "s/__VIP__/${VIP}/g" \
    -e "s/__NETWORK_NIC__/${NETWORK_NIC}/g" \
    -i keepalived/*.conf

# 分发仓库文件
scp -r * root@${MASTER1}:/tmp/
scp -r * root@${MASTER2}:/tmp/
scp -r * root@${MASTER3}:/tmp/

# 分发配置
ssh root@${MASTER1} "cd /tmp/keepalived/ && cp keepalived1.conf /etc/keepalived/keepalived.conf && bash install.sh"
ssh root@${MASTER2} "cd /tmp/keepalived/ && cp keepalived2.conf /etc/keepalived/keepalived.conf && bash install.sh"
ssh root@${MASTER3} "cd /tmp/keepalived/ && cp keepalived3.conf /etc/keepalived/keepalived.conf && bash install.sh"

exit 1
cd scripts
./init.sh
./create_cluster.sh ${API_SERVER}
./nginx_ingress.sh
