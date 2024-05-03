#!/bin/sh

yum install -y ./haproxy-1.5.18-9.el7_9.1.x86_64.rpm

systemctl enable --now haproxy
