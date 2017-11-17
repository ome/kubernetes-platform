#!/bin/bash
set -eu

if [ $# -ne 2 ]; then
    echo USAGE $(basename $0) environment command
    exit 1
fi
if [ "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" != "$PWD" ]; then
    echo Must be run from script parent directory
    exit 2
fi

ENVIRONMENT="$1"
CMD="$2"

export TF_VAR_username=OS_USERNAME
export TF_VAR_password=OS_PASSWORD
export TF_VAR_tenant=OS_TENANT_ID
export TF_VAR_auth_url=OS_AUTH_URL

TERRAFORM_STATE="$ENVIRONMENT/terraform.tfstate"
TERRAFORM_VARFILE="$ENVIRONMENT/kubetest.tfvars"
TERRAFORM_DIR="$ENVIRONMENT"

terraform=/usr/local/bin/terraform
$terraform version

if [ "$CMD" = init -o "$CMD" = get ]; then
    $terraform "$CMD" "$TERRAFORM_DIR"
else
    $terraform "$CMD" -state "$TERRAFORM_STATE" -var-file="$TERRAFORM_VARFILE" "$TERRAFORM_DIR"
fi
