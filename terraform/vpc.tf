# VPC with public and private subnets
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = "${var.project_name}-${var.branch_name}-vpc"
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnet_cidrs
  public_subnets  = var.public_subnet_cidrs

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Environment = var.environment
    Project     = var.project_name-var.branch_name
  }
}

# Security group for Lambda
resource "aws_security_group" "lambda_sg" {
  name        = "${var.project_name}-${var.branch_name}-lambda-sg"
  description = "Security group for Lambda function"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name-var.branch_name
  }
}
