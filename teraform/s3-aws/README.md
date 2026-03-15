# AWS S3 Terraform Stack

This directory contains a standalone Terraform stack for provisioning an Amazon S3 bucket.

The stack is separated from the EKS stack so that storage lifecycle and Terraform state remain independently manageable.

## Included Resources

This stack defines:

- an S3 bucket
- bucket versioning
- default server-side encryption
- public access blocking controls

## File Overview

- `versions.tf`: Terraform and provider version requirements
- `variables.tf`: Input variables
- `main.tf`: S3 resources
- `outputs.tf`: Exported values
- `terraform.tfvars.example`: Example input values

## Usage Guidance

This stack has been added for repository readiness only. It has not been executed automatically.

Typical workflow:

```bash
cd teraform/s3-aws
terraform init
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

## Operational Notes

- Bucket versioning is enabled.
- Default server-side encryption uses `AES256`.
- Public access is fully blocked.
