# Data source for ECR repository
data "aws_ecr_repository" "app" {
  name = "simpletimeservice-${var.branch_name}"
}

# ECR repository policy for Lambda access
resource "aws_ecr_repository_policy" "lambda_access" {
  repository = data.aws_ecr_repository.app.name
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "LambdaECRImageRetrievalPolicy",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = [
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ]
      }
    ]
  })
}
