variable "aws_region" {
  description = "AWS region for the S3 bucket."
  type        = string
  default     = "ap-southeast-3"
}

variable "bucket_name" {
  description = "S3 bucket name to create."
  type        = string
  default     = "mbu-eks-assets"
}

variable "tags" {
  description = "Common tags applied to S3 resources."
  type        = map(string)
  default = {
    Project     = "mbu"
    ManagedBy   = "terraform"
    Environment = "production"
  }
}
