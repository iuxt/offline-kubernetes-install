#!/bin/bash
set -euo pipefail

yum install -y ./*.rpm
ls *.tar | xargs -I {} docker load -i {}
systemctl enable --now kubelet

