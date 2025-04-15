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

## Project Structure
```
.
├── app/                  # Application code
│   ├── main.py           # FastAPI application
│   ├── requirements.txt  # Python dependencies
│   └── Dockerfile        # Container definition
├── tests/                # Test suite
│   └── test_main.py      # Unit tests for the application
├── terraform/            # Infrastructure as Code
│   ├── main.tf           # Main Terraform configuration
│   ├── outputs.tf        # Output definitions
│   └── terraform.tfvars  # Default variable values
├── .github/              # GitHub Actions workflows
│   └── workflows/
│       ├── ci-cd.yml             # CI/CD pipeline
│       ├── security-scan.yml     # Security scanning
│       ├── codeql-analysis.yml   # Code quality analysis
│       └── dependency-review.yml # Dependency review
├── Dockerfile.test       # Docker configuration for testing
├── requirements.txt      # Project-level dependencies
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
pip install -r requirements.txt
```

### Running the Application

#### Locally
1. Navigate to the app directory:
```bash
cd app
```

2. Run the application:
```bash
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
pytest
```

To run tests in a Docker container:
```bash
docker build -f Dockerfile.test -t simpletimeservice-test .
docker run simpletimeservice-test
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
bandit -r app/

# Check dependencies for vulnerabilities
safety check -r requirements.txt
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
1. Navigate to the terraform directory:
```bash
cd terraform
```

2. The deployment requires only two commands:

   Plan the deployment:
   ```bash
   terraform plan
   ```

   Apply the configuration:
   ```bash
   terraform apply
   ```

After successful deployment, the API Gateway URL will be displayed in the outputs. You can access the SimpleTimeService through this URL.

#### Advanced: Remote State Management (Optional)
For production environments, you can use remote state management:

1. Create a file named `main.tf.remote` with the following backend configuration:
```hcl
terraform {
  backend "s3" {
    bucket         = "simpletimeservice-terraform-state"
    key            = "terraform.tfstate"
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
```

2. Create and run the backend setup script:
```bash
# Create setup-backend.sh
chmod +x setup-backend.sh
./setup-backend.sh
```

3. Initialize Terraform with the remote backend:
```bash
terraform init
```

### Infrastructure Overview
This Terraform configuration creates:
- VPC with 2 public and 2 private subnets
- Serverless Lambda function running in private subnets
- API Gateway to provide public access to the service
- All necessary IAM roles and security groups

The infrastructure uses a pre-built Docker image from Docker Hub that is maintained through the CI/CD pipeline.

## CI/CD Pipeline
The project uses GitHub Actions for continuous integration and deployment:
- Build and Test: Runs on every push and pull request
- Security Scanning: Checks for vulnerabilities
- Docker Image Building: Creates and pushes the container image to Docker Hub
- Deployment: Updates the infrastructure with the new image

The CI/CD pipeline automatically builds and deploys changes to the application code whenever changes are pushed to the main branch.

## Contributing
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Commit your changes: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature/your-feature-name`
5. Open a pull request

*This project was created as part of the Particle41 technical assessment.*
