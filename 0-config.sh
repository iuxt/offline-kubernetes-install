#!/bin/bash

master1="10.0.0.112"
master2="10.0.0.122"
master3="10.0.0.132"
vip="10.0.0.32"

sed -e "s/10.0.0.11/${master1}/g" \
    -e "s/10.0.0.12/${master2}/g" \
    -e "s/10.0.0.13/${master3}/g" \
    -e "s/10.0.0.3/${vip}/g" \
    -i keepalived/*.conf