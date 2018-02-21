#!/bin/sh
# https://github.com/jupyterhub/zero-to-jupyterhub-k8s/blob/v0.6/doc/source/security.md#secure-access-to-helm

set -eu

kubectl --namespace=kube-system patch deployment tiller-deploy --type=json --patch='[{"op": "add", "path": "/spec/template/spec/containers/0/command", "value": ["/tiller", "--listen=localhost:44134"]}]'
kubectl -n kube-system delete service tiller-deploy
