# This script creates the S3 bucket and DynamoDB table for Terraform state management
# Run this once before the first terraform apply

# Set variables
$BUCKET_NAME = "simpletimeservice-terraform-state"
$TABLE_NAME = "simpletimeservice-terraform-lock"
$REGION = "us-east-1"

# Create S3 bucket with versioning enabled
Write-Host "Creating S3 bucket..."
aws s3api create-bucket `
  --bucket $BUCKET_NAME `
  --region $REGION `
  --create-bucket-configuration LocationConstraint=$REGION

# Enable versioning on the bucket
Write-Host "Enabling versioning on the bucket..."
aws s3api put-bucket-versioning `
  --bucket $BUCKET_NAME `
  --versioning-configuration Status=Enabled

# Enable encryption on the bucket
Write-Host "Enabling encryption on the bucket..."
aws s3api put-bucket-encryption `
  --bucket $BUCKET_NAME `
  --server-side-encryption-configuration '{\"Rules\": [{\"ApplyServerSideEncryptionByDefault\": {\"SSEAlgorithm\": \"AES256\"}}]}'

# Create DynamoDB table for state locking
Write-Host "Creating DynamoDB table for state locking..."
aws dynamodb create-table `
  --table-name $TABLE_NAME `
  --attribute-definitions AttributeName=LockID,AttributeType=S `
  --key-schema AttributeName=LockID,KeyType=HASH `
  --billing-mode PAY_PER_REQUEST `
  --region $REGION

Write-Host "Terraform backend infrastructure has been created."
Write-Host "You can now run 'terraform init', 'terraform plan', and 'terraform apply'."
