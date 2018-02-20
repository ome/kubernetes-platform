#!/bin/sh
# Install nginx-ingress with a production SSL certificate

set -eu

kubectl create --namespace=kube-system secret tls star-openmicroscopy-org --key PRIVATE.key --cert CERTIFICATE.crt+bundle

helm repo update
# If the certificate is not updated you may need to force an upgrade/restart
helm upgrade --install nginx-ingress stable/nginx-ingress --version=0.9.3 --namespace=kube-system -f nginx-ingress-config.yaml
