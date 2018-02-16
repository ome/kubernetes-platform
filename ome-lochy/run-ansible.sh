#!/bin/bash
set -eu

export ANSIBLE_HOST_KEY_CHECKING=False
ANSIBLE_ARGS="-i ./inventory --become --ask-become-pass --diff"
EXTRA_VARS='{"helm_enabled":true, "kube_network_plugin":"flannel"}'

if [ $# -gt 0 ]; then
    ansible-playbook $ANSIBLE_ARGS -e "$EXTRA_VARS" "$@"
else
    ansible-playbook $ANSIBLE_ARGS -e "$EXTRA_VARS" preinstall/playbook.yml kubespray/cluster.yml
fi
