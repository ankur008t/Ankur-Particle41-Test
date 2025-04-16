terraform {
  required_version = ">= 1.0.0"
  
  # Backend configuration for state management
  backend "s3" {
    bucket         = "simpletimeservice-${var.branch_name}-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "simpletimeservice-${var.branch_name}-terraform-lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
