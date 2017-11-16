#!/bin/sh
set -eu

CMD="$1"
export TF_VAR_username=OS_USERNAME
export TF_VAR_password=OS_PASSWORD
export TF_VAR_tenant=OS_TENANT_ID
export TF_VAR_auth_url=OS_AUTH_URL

# Must be run from this directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

TERRAFORM_STATE="./terraform.tfstate"
TERRAFORM_VARFILE=kubetest.tfvars

#TERRAFORM_DIR=kubespray/contrib/terraform/openstack
TERRAFORM_DIR=.

terraform=/usr/local/bin/terraform
$terraform version

if [ "$CMD" = init -o "$CMD" = get ]; then
    $terraform "$CMD" "$TERRAFORM_DIR"
else
    $terraform "$CMD" -state "$TERRAFORM_STATE" -var-file="$TERRAFORM_VARFILE" "$TERRAFORM_DIR"
fi
