variable "aws_region" {
  description = "AWS region for the RDS instance."
  type        = string
  default     = "ap-southeast-3"
}

variable "rds_identifier" {
  description = "RDS instance identifier."
  type        = string
  default     = "development"
}

variable "master_username" {
  description = "Master username for the PostgreSQL instance."
  type        = string
  default     = "postgresadmin"
}

variable "master_password" {
  description = "Master password for the PostgreSQL instance."
  type        = string
  sensitive   = true
}

variable "instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t4g.micro"
}

variable "allocated_storage" {
  description = "Allocated storage in GiB."
  type        = number
  default     = 20
}

variable "engine_version" {
  description = "PostgreSQL engine version."
  type        = string
  default     = "16"
}

variable "publicly_accessible" {
  description = "Whether the RDS instance is publicly accessible."
  type        = bool
  default     = true
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access PostgreSQL."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "Common tags applied to RDS resources."
  type        = map(string)
  default = {
    Project     = "mbu"
    ManagedBy   = "terraform"
    Environment = "development"
  }
}
