#!/bin/bash
set -euo pipefail

source cluster.env

if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script"
    exit 1
fi

# 部署之前先分发 init 内容
scp -r init/ root@${MASTER1}:/tmp/
scp -r init/ root@${MASTER2}:/tmp/
scp -r init/ root@${MASTER3}:/tmp/
ssh root@${MASTER1} "cd /tmp/init/ && ./init.sh"
ssh root@${MASTER2} "cd /tmp/init/ && ./init.sh"
ssh root@${MASTER3} "cd /tmp/init/ && ./init.sh"

# 生成keepalived配置文件
git checkout keepalived/*.conf
sed -e "s/__MASTER1__/${MASTER1}/g" \
    -e "s/__MASTER2__/${MASTER2}/g" \
    -e "s/__MASTER3__/${MASTER3}/g" \
    -e "s/__VIP__/${API_SERVER}/g" \
    -e "s/__NETWORK_NIC__/${NETWORK_NIC}/g" \
    -i keepalived/*.conf

# 分发仓库文件
rsync -avz --exclude=temp * root@${MASTER1}:/tmp/
rsync -avz --exclude=temp * root@${MASTER2}:/tmp/
rsync -avz --exclude=temp * root@${MASTER3}:/tmp/

# keepalived 配置
ssh root@${MASTER1} "cd /tmp/keepalived/ && bash install.sh && cp -r keepalived1.conf /etc/keepalived/keepalived.conf && systemctl restart keepalived"
ssh root@${MASTER2} "cd /tmp/keepalived/ && bash install.sh && cp -r keepalived2.conf /etc/keepalived/keepalived.conf && systemctl restart keepalived"
ssh root@${MASTER3} "cd /tmp/keepalived/ && bash install.sh && cp -r keepalived3.conf /etc/keepalived/keepalived.conf && systemctl restart keepalived"

# 创建集群
ssh root@${MASTER1} "cd /tmp/init/ && ./init.sh"
ssh root@${MASTER2} "cd /tmp/init/ && ./init.sh"
ssh root@${MASTER3} "cd /tmp/init/ && ./init.sh"

cd kubeadm
./create_cluster.sh ${API_SERVER} | tee /tmp/install.log

# 获取安装信息
MASTER_JOIN_COMMAND=$(cat /tmp/install.log | grep -A 5 "You can now join any number of the control-plane" | grep -vE "You can now join any number of the control-plane|^$")

ssh root@${MASTER2} "${MASTER_JOIN_COMMAND}"
ssh root@${MASTER3} "${MASTER_JOIN_COMMAND}"