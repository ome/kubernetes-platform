#!/bin/sh

set -eu

helm repo update
helm install stable/nginx-ingress --version=0.9.3 --name=nginx-ingress --namespace=kube-system -f nginx-ingress-config.yaml
