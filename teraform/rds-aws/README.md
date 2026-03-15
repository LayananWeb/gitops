# AWS RDS Terraform Stack

This directory contains a standalone Terraform stack for provisioning an Amazon RDS PostgreSQL instance.

The stack is separated from the EKS and S3 stacks so that infrastructure state remains isolated by component.

## Included Resources

This stack defines:

- a security group for PostgreSQL access
- a DB subnet group based on the default VPC subnets
- an RDS PostgreSQL instance

## File Overview

- `versions.tf`: Terraform and provider version requirements
- `variables.tf`: Input variables
- `main.tf`: RDS resources
- `outputs.tf`: Exported values
- `terraform.tfvars.example`: Example input values

## Usage Guidance

This stack has been added for repository readiness only. It has not been executed automatically.

Typical workflow:

```bash
cd teraform/rds-aws
terraform init
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

## Operational Notes

- `master_password` must be supplied through a `terraform.tfvars` file or environment variable.
- The current example uses the default VPC and its subnets.
- Restrict `allowed_cidr_blocks` before applying in shared or production environments.
