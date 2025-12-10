#!/bin/bash

read -r -p "Enter the environment to destroy (demo/non-prod/prod): " env
set -e

rm -rf .terraform

if [ "${env}" == "demo" ] || [ "${env}" == "non-prod" ] || [ "${env}" == "prod" ]; then
    echo "Destroying Terraform resources for environment: ${env}"

    terraform init \
        -backend-config="key=heartbeat/${env}/terraform.tfstate"

    # Ensure we are in the correct workspace
    terraform workspace list
    terraform workspace select -or-create "${env}"

    terraform fmt --recursive

    # Destroy all resources in the selected environment
    terraform destroy -var="environment=${env}" -auto-approve

else
    echo "Invalid environment. Use: demo | non-prod | prod"
fi
