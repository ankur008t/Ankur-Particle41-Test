aws_region           = "us-east-1"
project_name         = "simpletimeservice"
environment          = "dev"
vpc_cidr             = "10.0.0.0/16"
availability_zones   = ["us-east-1a", "us-east-1b"]
private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnet_cidrs  = ["10.0.101.0/24", "10.0.102.0/24"]
container_image      = "yourdockerhubusername/simpletimeservice:latest"  # Public Docker Hub image
service_desired_count = 2
