#!/bin/sh
export ANSIBLE_HOST_KEY_CHECKING=False
export TERRAFORM_STATE_ROOT="$PWD"
EXTRA_VARS='{"helm_enabled":true, "kube_network_plugin":"flannel"}'

if [ $# -gt 0 ]; then
    ansible-playbook -i inventory/ --become -e "$EXTRA_VARS" "$@"
else
    ansible-playbook -i inventory/ --become -e "$EXTRA_VARS" kubespray/cluster.yml kubespray/contrib/network-storage/glusterfs/glusterfs.yml
fi
