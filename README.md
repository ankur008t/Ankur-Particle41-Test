# SimpleTimeService Project

## Overview
SimpleTimeService is a lightweight microservice that returns the current timestamp and the IP address of the visitor. This project demonstrates containerization, testing, and infrastructure-as-code best practices.

## Table of Contents
- [Features](#features)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running the Application](#running-the-application)
- [Testing](#testing)
- [Security Scanning](#security-scanning)
- [Infrastructure as Code](#infrastructure-as-code)
  - [Deployment Instructions](#deployment-instructions)
  - [Infrastructure Overview](#infrastructure-overview)
- [CI/CD Pipeline](#cicd-pipeline)
- [Contributing](#contributing)

## Features
- RESTful API endpoint that returns current timestamp and visitor IP
- Containerized application with Docker
- Non-root user execution for enhanced security
- Comprehensive test suite
- Security scanning with GitHub Actions
- Infrastructure as Code with Terraform (AWS)
- AWS Lambda deployment with API Gateway
- Amazon ECR integration for container image storage
- Automated CI/CD pipeline with GitHub Actions

## Project Structure
```
.
├── app/                  # Application code
│   ├── main.py           # FastAPI application
│   ├── requirements.txt  # Python dependencies
├── tests/                # Test suite
│   ├── test_main.py      # Unit tests for the application
│   └── requirements-test.txt # Test dependencies
├── terraform/            # Infrastructure as Code
│   ├── main.tf           # Main Terraform configuration
│   ├── outputs.tf        # Output definitions
│   ├── variables.tf      # Variable declarations
│   └── terraform.tfvars  # Default variable values
├── .github/              # GitHub Actions workflows
│   └── workflows/
│       ├── ci-cd.yml             # CI/CD pipeline
│       ├── security-scan.yml     # Security scanning
│       ├── codeql-analysis.yml   # Code quality analysis
│       └── dependency-review.yml # Dependency review
├── Dockerfile            # Docker configuration for the application
└── README.md             # Project documentation
```

## Getting Started

### Prerequisites
- Python 3.11 or higher
- Docker
- Terraform (for infrastructure deployment)
- AWS CLI (configured with appropriate credentials for Terraform)

### Installation
1. Clone the repository:
```bash
git clone https://github.com/ankur008t/Ankur-Particle41-Test.git
cd Ankur-Particle41-Test
```

2. Install dependencies:
```bash
pip install -r app/requirements.txt
```

### Running the Application

#### Locally
1. Run the application:
```bash
cd app
python main.py
```

Access the service at http://localhost:8000/

#### Using Docker
1. Build the Docker image:
```bash
docker build -t simpletimeservice .
```

2. Run the container:
```bash
docker run -p 8000:8000 simpletimeservice
```

Access the service at http://localhost:8000/

## Testing
Run the test suite to ensure everything is working correctly:
```bash
pip install -r tests/requirements-test.txt
pytest
```

## Security Scanning
This project includes several security scanning tools integrated via GitHub Actions:
- Bandit: Static code analysis for Python
- Safety: Dependency vulnerability scanning
- CodeQL: Advanced semantic code analysis
- Dependency Review: Checks for vulnerabilities in dependencies

To run security scans locally:
```bash
# Install security tools
pip install bandit safety

# Run static code analysis
bandit -r app/ --skip B104

# Check dependencies for vulnerabilities
safety check -r app/requirements.txt
```

## Infrastructure as Code

### Deployment Instructions

#### Prerequisites
- AWS CLI installed and configured
- Terraform installed (v1.0+)

#### Authentication
To deploy this infrastructure, you need to authenticate with AWS. Do NOT commit credentials to the repository.

Choose one of the following authentication methods:

1. AWS CLI Configuration:
```bash
aws configure
```
You'll be prompted to enter:
- AWS Access Key ID
- AWS Secret Access Key
- Default region
- Default output format

2. Environment Variables:
```bash
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_REGION="us-east-1"
```

#### Deploying the Infrastructure
1. Setup S3 and DynamoDB for Terraform backend:
```bash
.\setup-backend.sh # for linux
```
```bash
.\setup-backend.ps1 # for windows
```

1. Navigate to the terraform directory:
```bash
cd terraform
```

2. Initialize Terraform:
```bash
terraform init # for remote backend
```
```bash
terraform init -backend=false # for local backend
```

3. Plan the deployment:
```bash
terraform plan
```

4. Apply the configuration:
```bash
terraform apply
```

After successful deployment, the API Gateway URL will be displayed in the outputs. You can access the SimpleTimeService through this URL.

### Infrastructure Overview
This Terraform configuration creates:
- VPC with 2 public and 2 private subnets
- Serverless Lambda function running in private subnets
- API Gateway to provide public access to the service
- Amazon ECR repository for storing container images
- All necessary IAM roles and security groups

The infrastructure uses a container image from Amazon ECR that is maintained through the CI/CD pipeline.

## CI/CD Pipeline
The project uses GitHub Actions for continuous integration and deployment:
- Build and Test: Runs on every push and pull request
- Security Scanning: Checks for vulnerabilities
- Docker Image Building: Creates and pushes the container image to Docker Hub and Amazon ECR
- Terraform Deployment: Provisions and updates the AWS infrastructure

The CI/CD pipeline automatically:
1. Runs tests and security scans
2. Builds the Docker image and pushes it to Amazon ECR
3. Deploys the infrastructure using Terraform
4. Updates the Lambda function to use the latest image

### CI/CD Workflow
The workflow is triggered on:
- Pushes to the main branch that modify app code, terraform code, Dockerfile, or CI/CD configuration
- Pull requests to the main branch

## Security Scan Results
Please find the security scan results at:
[security scan results](https://github.com/ankur008t/Ankur-Particle41-Test/security/code-scanning/tools/CodeQL/status)

## Live Demo
The SimpleTimeService is currently deployed and accessible at:
[Simple Time Service](https://dp21vbdhtb.execute-api.us-east-1.amazonaws.com/dev/)
This endpoint returns a JSON response with the current timestamp and your IP address.

## Contributing
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Commit your changes: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature/your-feature-name`
5. Open a pull request

*This project was created as part of the Particle41 technical assessment.*
