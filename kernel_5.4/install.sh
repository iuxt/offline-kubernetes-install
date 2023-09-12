#!/bin/bash
set -euo pipefail

yum install -y 1/*

echo "当前系统安装的内核有:"
awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg

KERNEL_ID=$(awk -F\' '$1=="menuentry " {print i++ ": " $2}' /etc/grub2.cfg | grep 5.4 | awk -F : '{print $1}')
echo "设置启动项为: $KERNEL_ID"
grub2-set-default $KERNEL_ID

## 生成grub配置
grub2-mkconfig -o /boot/grub2/grub.cfg




# # 更新kernel tools
# yum remove -y kernel-tools-libs-3.10.0
# yum remove -y kernel-tools-3.10.0
# yum install -y 2/*
# # 删除旧内核（可选）
# yum remove -y kernel-3.10.0
