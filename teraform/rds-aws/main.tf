data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default_vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "rds" {
  name        = "${var.rds_identifier}-rds-sg"
  description = "PostgreSQL access for the RDS instance"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "PostgreSQL access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.rds_identifier}-rds-sg"
  })
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.rds_identifier}-db-subnet-group"
  subnet_ids = data.aws_subnets.default_vpc_subnets.ids

  tags = merge(var.tags, {
    Name = "${var.rds_identifier}-db-subnet-group"
  })
}

resource "aws_db_instance" "postgres" {
  identifier = var.rds_identifier

  engine         = "postgres"
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage = var.allocated_storage
  storage_type      = "gp3"

  db_name  = "postgres"
  username = var.master_username
  password = var.master_password

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.this.name

  publicly_accessible     = var.publicly_accessible
  multi_az                = false
  backup_retention_period = 1

  skip_final_snapshot = true
  deletion_protection = false

  tags = merge(var.tags, {
    Name = var.rds_identifier
  })
}
