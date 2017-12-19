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
cd "$ENVIRONMENT"
CMD="$2"

TERRAFORM_STATE="terraform.tfstate"
TERRAFORM_VARFILE="$ENVIRONMENT.tfvars"
TERRAFORM_DIR="."

terraform version

if [ "$CMD" = init -o "$CMD" = get ]; then
    terraform "$CMD" "$TERRAFORM_DIR"
else
    terraform "$CMD" -state "$TERRAFORM_STATE" -var-file="$TERRAFORM_VARFILE" "$TERRAFORM_DIR"
fi
