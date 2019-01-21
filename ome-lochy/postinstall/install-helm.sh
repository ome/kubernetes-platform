#!/bin/sh
# Install and secure access to Helm
set -eu

VERSION=2.12.2

PLATFORM=`uname | tr '[:upper:]' '[:lower:]'`
curl -L https://storage.googleapis.com/kubernetes-helm/helm-v${VERSION}-${PLATFORM}-amd64.tar.gz | tar -x -

echo '{"apiVersion":"v1","kind":"ServiceAccount","metadata":{"name": "tiller"}}' | kubectl apply -n kube-system -f -
echo '{"apiVersion": "rbac.authorization.k8s.io/v1","kind": "ClusterRoleBinding","metadata":{"name":"tiller"},"roleRef":{"apiGroup":"rbac.authorization.k8s.io","kind": "ClusterRole","name": "cluster-admin"},"subjects":[{"kind": "ServiceAccount","name": "tiller","namespace": "kube-system"}]}' | kubectl apply -n kube-system -f -

${PLATFORM}-amd64/helm init --upgrade --service-account tiller

# https://github.com/jupyterhub/zero-to-jupyterhub-k8s/blob/8209ea252a1ec2cdb90640ea2a2735467b4aadbc/doc/source/security.md#secure-access-to-helm
kubectl --namespace=kube-system patch deployment tiller-deploy --type=json --patch='[{"op": "add", "path": "/spec/template/spec/containers/0/command", "value": ["/tiller", "--listen=localhost:44134"]}]'
