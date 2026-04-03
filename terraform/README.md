# Terraform Configuration for Crypto Data Platform

## Security Notes

⚠️ **Never commit sensitive data to Git!**

## Setup

1. Copy `terraform.tfvars.example` to `terraform.tfvars`:
cp terraform.tfvars.example terraform.tfvars
2. Edit `terraform.tfvars` and set your passwords

3. Initialize Terraform:
terraform init


4. Plan and apply:
terraform plan
terraform apply

## Environment Variables
You can also use environment variables:
export TF_VAR_postgres_password="your_password"
export TF_VAR_minio_password="your_password"

## Destroy Infrastructure
terraform destroy


