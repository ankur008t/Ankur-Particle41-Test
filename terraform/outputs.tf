# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

# API Gateway Output
output "api_gateway_url" {
  description = "URL of the API Gateway endpoint"
  value       = "${aws_apigatewayv2_stage.stage.invoke_url}/"
}

# Lambda Function Outputs
output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.app.function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.app.arn
}

# Container Image Output
output "container_image" {
  description = "Container image used for the service"
  value       = var.container_image
}

# Environment Information
output "environment" {
  description = "Deployment environment"
  value       = var.environment
}

output "region" {
  description = "AWS region"
  value       = var.aws_region
}

# Service Information
output "service_name" {
  description = "Name of the deployed service"
  value       = var.project_name
}

output "service_desired_count" {
  description = "Desired count of service instances"
  value       = var.service_desired_count
}
