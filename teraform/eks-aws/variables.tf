variable "aws_region" {
  description = "AWS region for the EKS cluster."
  type        = string
  default     = "ap-southeast-3"
}

variable "cluster_name" {
  description = "EKS cluster name."
  type        = string
  default     = "mbu-eks"
}

variable "cluster_version" {
  description = "Kubernetes version for EKS."
  type        = string
  default     = "1.31"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.20.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets."
  type        = list(string)
  default = [
    "10.20.0.0/24",
    "10.20.1.0/24",
  ]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets."
  type        = list(string)
  default = [
    "10.20.10.0/24",
    "10.20.11.0/24",
  ]
}

variable "availability_zones" {
  description = "Availability zones used by the VPC."
  type        = list(string)
  default = [
    "ap-southeast-3a",
    "ap-southeast-3b",
  ]
}

variable "node_instance_types" {
  description = "EC2 instance types for the node group."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_desired_size" {
  description = "Desired number of worker nodes."
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Minimum number of worker nodes."
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Maximum number of worker nodes."
  type        = number
  default     = 3
}

variable "tags" {
  description = "Common tags applied to resources."
  type        = map(string)
  default = {
    Project     = "mbu"
    ManagedBy   = "terraform"
    Environment = "production"
  }
}
