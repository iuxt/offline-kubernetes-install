#!/bin/bash
yum install -y ./*.rpm
cd tar
ls *.tar | xargs -I {} docker load -i {}
systemctl enable --now kubelet

