#!/bin/bash
ls *.tar | xargs -I {} docker load -i {}
kubectl taint node centos7 node-role.kubernetes.io/master-
kubectl apply -f ./nginx-ingress-daemonset.yaml
