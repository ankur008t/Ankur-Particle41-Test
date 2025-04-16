terraform {
  required_version = ">= 1.0.0"
  
  # Backend configuration for state management
  backend "s3" {
    bucket         = "simpletimeservice-terraform-state"
    key            = "${get_env("TF_WORKSPACE", "default")}/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "simpletimeservice-terraform-lock"
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