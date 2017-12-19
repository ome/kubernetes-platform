#!/bin/bash
set -eu

if [ $# -lt 1 ]; then
    echo USAGE $(basename $0) environment [...]
    exit 1
fi
if [ "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" != "$PWD" ]; then
    echo Must be run from script parent directory
    exit 2
fi

ENVIRONMENT="$1"
cd "$ENVIRONMENT"
shift

export ANSIBLE_HOST_KEY_CHECKING=False
export TERRAFORM_STATE_ROOT="."
ANSIBLE_ARGS="-i ./inventory --become"
EXTRA_VARS='{"helm_enabled":true, "kube_network_plugin":"flannel"}'

if [ $# -gt 0 ]; then
    ansible-playbook $ANSIBLE_ARGS -e "$EXTRA_VARS" "$@"
else
    ansible-playbook $ANSIBLE_ARGS -e "$EXTRA_VARS" kubespray/cluster.yml kubespray/contrib/network-storage/glusterfs/glusterfs.yml
fi
