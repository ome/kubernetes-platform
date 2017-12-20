# Nginx Ingress Controller

The following manifests are copied from https://github.com/kubernetes/ingress-nginx/tree/cc7fd9ee6662a4cbd7b26be8a9e57794ed1508a2/deploy:
- configmap.yaml
- default-backend.yaml
- namespace.yaml
- rbac.yaml
- tcp-services-configmap.yaml
- udp-services-configmap.yaml

with-rbac-daemonset.yaml is based on with-rbac from the same repository, but will listen on the ports 80 and 443 of all master hosts.
This is an alternative to using a LoadBalancer.
