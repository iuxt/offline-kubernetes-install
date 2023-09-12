#!/bin/bash
set -euo pipefail


ls *.tar | xargs -I {} docker load -i {}
kubectl apply -f ./kube-flannel.yml
