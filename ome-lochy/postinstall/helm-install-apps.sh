#!/bin/sh

set -eu

helm repo update
helm upgrade --install nginx-ingress stable/nginx-ingress --version=0.9.3 --namespace=kube-system -f nginx-ingress-config.yaml
