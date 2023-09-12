#!/bin/bash
set -euo pipefail

yum install -y ./*.rpm
systemctl enable --now keepalived