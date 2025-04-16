variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "service_desired_count" {
  description = "Number of instances of the service to run"
  type        = number
}

variable "container_image" {
  description = "Docker image for the application"
  type        = string
  default     = "placeholder"  # Add a default value
}

variable "aws_account" {
  description = "AWS Account Number"
  type        = string
}

variable "image_tag" {
  description = "The tag for the container image"
  type        = string
  default     = "latest"
}

variable "branch_name" {
  description = "The name of the branch being deployed (e.g., main, dev, feature)"
  type        = string
  default     = "main"  
}
