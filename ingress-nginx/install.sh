#!/bin/bash
set -euo pipefail


ls *.tar | xargs -I {} docker load -i {}
kubectl taint node $(hostname) node-role.kubernetes.io/master-
kubectl apply -f ./nginx-ingress-daemonset.yaml
