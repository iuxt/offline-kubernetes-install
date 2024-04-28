#!/bin/bash

yum install -y ./*.rpm
systemctl enable --now nginx

