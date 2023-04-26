#!/bin/bash
set -euo pipefail

yum remove -y kernel-tools-libs-3.10.0
yum remove -y kernel-tools-3.10.0

cd 1 && yum install -y ./* && cd ..
cd 2 && yum install -y ./* && cd ..

awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg
grub2-set-default 0

## 生成grub配置
grub2-mkconfig -o /boot/grub2/grub.cfg

# 删除旧内核（可选）
# yum remove -y kernel-3.10.0
