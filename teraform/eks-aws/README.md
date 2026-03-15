# AWS EKS Terraform Stack

This directory contains a standalone Terraform stack for provisioning an Amazon EKS cluster and its supporting network resources.

The stack is intentionally isolated from other Terraform definitions in this repository so that infrastructure state remains separated by concern.

## Included Resources

This stack defines:

- a dedicated VPC
- public and private subnets
- an internet gateway
- a NAT gateway
- route tables and subnet associations
- IAM roles for the EKS control plane and worker nodes
- an EKS cluster
- a managed node group

## File Overview

- `versions.tf`: Terraform and provider version requirements
- `variables.tf`: Input variables
- `main.tf`: Core EKS and networking resources
- `outputs.tf`: Exported values
- `terraform.tfvars.example`: Example input values

## Usage Guidance

This stack has been added for repository readiness only. It has not been executed automatically.

Typical workflow:

```bash
cd teraform/eks-aws
terraform init
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

## Operational Notes

- Worker nodes are placed in private subnets.
- The cluster endpoint is enabled for both public and private access.
- Private subnet outbound access is provided through a NAT gateway.
- S3 resources are intentionally managed in the separate [s3-aws](/Users/withyou/Documents/gitopss/teraform/s3-aws) stack.
- Remote state is not configured yet. For collaborative use, an S3 backend with DynamoDB state locking is recommended.
