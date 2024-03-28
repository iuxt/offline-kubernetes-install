#!/bin/bash

yum install -y nginx/*.rpm
systemctl enable --now nginx
