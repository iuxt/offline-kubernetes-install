#!/bin/bash
set -euo pipefail

yum install -y ./*.rpm
ls *.tar | xargs -I {} docker load -i {}

cd ../docker && bash ./install.sh && cd -
cd ../flannel && bash install.sh

systemctl enable --now kubelet

