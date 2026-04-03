#!/bin/bash
# Script to safely run terraform with environment variables

cd ~/crypto-data-project/terraform

# Check if terraform.tfvars exists
if [ ! -f terraform.tfvars ]; then
    echo "Warning: terraform.tfvars not found!"
    echo "Copy terraform.tfvars.example to terraform.tfvars and set your passwords"
    exit 1
fi

# Load environment variables from .env if exists
if [ -f ../.env ]; then
    set -a
    source ../.env
    set +a
    export TF_VAR_postgres_password="$POSTGRES_PASSWORD"
    export TF_VAR_minio_password="$MINIO_ROOT_PASSWORD"
fi

# Run terraform
terraform init
terraform plan
echo ""
read -p "Do you want to apply? (y/n) " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    terraform apply -auto-approve
fi
