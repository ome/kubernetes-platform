#!/bin/bash
set -eu
EXTRA_VARS="{}"

export ANSIBLE_HOST_KEY_CHECKING=False

ANSIBLE_ARGS="-i ./inventory --become --ask-become-pass"

if [ $# -gt 0 ]; then
    ansible-playbook $ANSIBLE_ARGS -e "$EXTRA_VARS" "$@"
else
    ansible-playbook $ANSIBLE_ARGS -e "$EXTRA_VARS" kubespray/cluster.yml kubespray/contrib/network-storage/glusterfs/glusterfs.yml
fi
