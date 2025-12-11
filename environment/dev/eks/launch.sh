#!/bin/bash

read -r -p "Enter the environment (dev/non-prod/prod): " env
set -e

rm -rf .terraform

# Allowed environments
if [[ "${env}" == "dev" || "${env}" == "non-prod" || "${env}" == "prod" || "${env}" == "demo" ]]; then
    echo "Running Terraform for environment: ${env}"

    terraform init \
        -backend-config="key=newproject/${env}/terraform.tfstate"

    terraform workspace list
    terraform workspace select -or-create "${env}"

    terraform fmt --recursive

    terraform plan -out=tfplan

    terraform apply tfplan
else
    echo "Invalid environment: ${env}"
    echo "Allowed: dev, non-prod, prod, demo"
fi
