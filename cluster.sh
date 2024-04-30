#!/bin/bash
set -eu

source .env

# 部署之前先分发 init 内容
scp -r init/ root@${MASTER1}:/tmp/
scp -r init/ root@${MASTER2}:/tmp/
scp -r init/ root@${MASTER3}:/tmp/
ssh root@${MASTER1} "cd /tmp/init/ && bash ./init.sh"
ssh root@${MASTER2} "cd /tmp/init/ && bash ./init.sh"
ssh root@${MASTER3} "cd /tmp/init/ && bash ./init.sh"

# 生成keepalived配置文件
for i in $(ls keepalived/keepalived*.conf); do
    cat ${i} | sed -e "s/__MASTER1__/${MASTER1}/g" \
        -e "s/__MASTER2__/${MASTER2}/g" \
        -e "s/__MASTER3__/${MASTER3}/g" \
        -e "s/__VIP__/${API_SERVER}/g" \
        -e "s/__NETWORK_NIC__/${NETWORK_NIC}/g" \
        > ${i}.tmp
done

# 生成nginx配置文件
sed -e "s/__MASTER1__/${MASTER1}/g" \
    -e "s/__MASTER2__/${MASTER2}/g" \
    -e "s/__MASTER3__/${MASTER3}/g" \
    -e "s/__VIP__/${API_SERVER}/g" \
    nginx/nginx.conf > nginx/nginx.conf.tmp

# 分发仓库文件
rsync -avz --exclude=temp * root@${MASTER1}:/tmp/
rsync -avz --exclude=temp * root@${MASTER2}:/tmp/
rsync -avz --exclude=temp * root@${MASTER3}:/tmp/

# keepalived 配置
ssh root@${MASTER1} "cd /tmp/keepalived/ && bash install.sh && cp -r keepalived1.conf.tmp /etc/keepalived/keepalived.conf && systemctl restart keepalived"
ssh root@${MASTER2} "cd /tmp/keepalived/ && bash install.sh && cp -r keepalived2.conf.tmp /etc/keepalived/keepalived.conf && systemctl restart keepalived"
ssh root@${MASTER3} "cd /tmp/keepalived/ && bash install.sh && cp -r keepalived3.conf.tmp /etc/keepalived/keepalived.conf && systemctl restart keepalived"

# nginx配置
ssh root@${MASTER1} "cd /tmp/nginx && bash install.sh && cp -rf nginx.conf.tmp /etc/nginx/nginx.conf && systemctl restart nginx"
ssh root@${MASTER2} "cd /tmp/nginx && bash install.sh && cp -rf nginx.conf.tmp /etc/nginx/nginx.conf && systemctl restart nginx"
ssh root@${MASTER3} "cd /tmp/nginx && bash install.sh && cp -rf nginx.conf.tmp /etc/nginx/nginx.conf && systemctl restart nginx"

# 安装Docker
ssh root@${MASTER1} "cd /tmp/docker/ && bash ./install.sh"
ssh root@${MASTER2} "cd /tmp/docker/ && bash ./install.sh"
ssh root@${MASTER3} "cd /tmp/docker/ && bash ./install.sh"

# 安装 kubeadm 组件
ssh root@${MASTER1} "cd /tmp/kubeadm/ && bash install.sh"
ssh root@${MASTER2} "cd /tmp/kubeadm/ && bash install.sh"
ssh root@${MASTER3} "cd /tmp/kubeadm/ && bash install.sh"

# 导入flannel镜像
ssh root@${MASTER1} "cd /tmp/flannel/ && bash install.sh"
ssh root@${MASTER2} "cd /tmp/flannel/ && bash install.sh"
ssh root@${MASTER3} "cd /tmp/flannel/ && bash install.sh"

# 创建集群
ssh root@${MASTER1} "cd /tmp/kubeadm && bash ./create_cluster.sh ${API_SERVER} | tee /tmp/install.log"

# 获取安装信息
MASTER_JOIN_COMMAND=$(ssh root@${MASTER1} 'cat /tmp/install.log | grep -A 5 "You can now join any number of the control-plane" | grep -vE "You can now join any number of the control-plane|^$."')

ssh root@${MASTER2} "${MASTER_JOIN_COMMAND}"
ssh root@${MASTER3} "${MASTER_JOIN_COMMAND}"
