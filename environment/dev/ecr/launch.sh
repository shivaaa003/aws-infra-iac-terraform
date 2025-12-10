#!/bin/bash

read -r -p "Enter the environment (demo/non-prod/prod): " env
set -e

rm -rf .terraform

if [ "${env}" == "demo" ] || [ "${env}" == "non-prod" ] || [ "${env}" == "prod" ]; then
    echo "Running Terraform for environment: ${env}"

    terraform init \
        -backend-config="key=heartbeat/${env}/terraform.tfstate"

    #separate state files per environment

    terraform workspace list
    terraform workspace select -or-create "${env}"
    
    terraform fmt --recursive
    terraform apply -var="environment=${env}" -auto-approve

    #Passes the selected environment into Terraform

else
    echo "Invalid environment. Use: demo | non-prod | prod"
fi


#