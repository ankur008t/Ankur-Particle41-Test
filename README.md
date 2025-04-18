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
  - [CI/CD Workflow](#cicd-workflow)
- [Security Scan Results](#security-scan-results)
- [Live Demo](#live-demo)
- [Contributing](#contributing)

## Features
- RESTful API endpoint that returns the current timestamp and visitor IP.
- Containerized application with Docker for portability.
- Non-root user execution for enhanced security.
- Comprehensive test suite with unit and integration tests.
- Security scanning integrated with GitHub Actions.
- Infrastructure as Code (IaC) with Terraform for AWS resources.
- AWS Lambda deployment with API Gateway integration.
- Amazon ECR integration for container image storage.
- Automated CI/CD pipeline with GitHub Actions.

## Project Structure
```
.
├── app/                  # Application code
│   ├── main.py           # FastAPI application
│   ├── requirements.txt  # Python dependencies
├── tests/                # Test suite
│   ├── test_main.py      # Unit tests for the application
│   ├── test_integration.py # Integration tests
│   └── requirements-test.txt # Test dependencies
├── terraform/            # Infrastructure as Code
│   ├── main.tf           # Main Terraform configuration
│   ├── outputs.tf        # Output definitions
│   ├── variables.tf      # Variable declarations
│   ├── terraform.tfvars  # Default variable values
│   ├── vpc.tf            # VPC configuration
│   ├── lambda.tf         # Lambda function configuration
│   ├── iam.tf            # IAM roles and policies
│   ├── ecr.tf            # Amazon ECR configuration
│   └── api_gateway.tf    # API Gateway configuration
├── .github/              # GitHub Actions workflows
│   └── workflows/
│       ├── ci-cd.yml             # CI/CD pipeline
│       ├── security-scan.yml     # Security scanning
│       ├── codeql-analysis.yml   # Code quality analysis
│       ├── dependency-review.yml # Dependency review
│       └── container-scan.yml    # Container security scanning
├── Dockerfile            # Docker configuration for the application
├── Dockerfile.lambda     # Docker configuration for AWS Lambda
├── Dockerfile.test       # Docker configuration for running tests
├── README.md             # Project documentation
├── LICENSE               # License file
└── setup-backend.sh      # Script to set up Terraform backend
```

## Getting Started

### Prerequisites
- Python 3.11 or higher
- Docker
- Terraform (v1.0+ for infrastructure deployment)
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

   Access the service at [http://localhost:8000/](http://localhost:8000/).

#### Using Docker
1. Build the Docker image:
   ```bash
   docker build -t simpletimeservice .
   ```

2. Run the container:
   ```bash
   docker run -p 8000:8000 simpletimeservice
   ```

   Access the service at [http://localhost:8000/](http://localhost:8000/).

## Testing
Run the test suite to ensure everything is working correctly:
```bash
pip install -r tests/requirements-test.txt
pytest
```

## Security Scanning
This project includes several security scanning tools integrated via GitHub Actions to ensure code quality and identify vulnerabilities:

### Tools Used
1. **Microsoft Defender for DevOps (MSDO)**:
   - Integrates static analysis tools into the development lifecycle.
   - Scans for security vulnerabilities, compliance issues, and other risks.
   - Automatically uploads results to the Security tab in the repository.
   - Runs on `windows-latest` and supports `.NET` projects.
   - **Trigger**: Runs on every push or pull request to the `main` branch and on a scheduled basis (every Friday at 14:19 UTC).
   - **Workflow File**: [defender-for-devops.yml](.github/workflows/defender-for-devops.yml)

   #### Key Features:
   - Uses the `microsoft/security-devops-action` to run the latest versions of static analysis tools.
   - Supports tools like Checkov for IaC scanning.
   - Results are uploaded in SARIF format to the Security tab for easy review.

   #### Environment Variables:
   - `GDN_CHECKOV_DOWNLOADEXTERNALMODULES`: Enables downloading external modules for Checkov.
   - `GDN_CHECKOV_USEPYTHONINSTALLATION`: Ensures Python installation is used for Checkov.
   - `PYTHONIOENCODING` and `PYTHONUTF8`: Set Python encoding to UTF-8 for compatibility.

2. **Bandit**:
   - Static code analysis for Python to identify common security issues.
   - Scans the `app/` directory for vulnerabilities.

3. **Safety**:
   - Scans Python dependencies for known vulnerabilities.
   - Checks `requirements.txt` and `requirements-test.txt`.

4. **CodeQL**:
   - Advanced semantic code analysis for identifying vulnerabilities and code quality issues.
   - Results are uploaded to the Security tab.

5. **Dependency Review**:
   - Checks for vulnerabilities in dependencies during pull requests.

6. **Trivy**:
   - Scans Docker images for vulnerabilities in the base image and dependencies.

### Running Security Scans Locally
To run security scans locally, follow these steps:

#### Microsoft Defender for DevOps
1. Install the MSDO CLI tool (if available locally).
2. Run the following command:
   ```bash
   msdo scan --output sarif
   ```

#### Bandit
```bash
pip install bandit
bandit -r app/
```

#### Safety
```bash
pip install safety
safety check -r app/requirements.txt
```

#### Trivy
```bash
docker run --rm aquasec/trivy:latest image simpletimeservice
```

### Viewing Results
- Results from Microsoft Defender for DevOps and CodeQL are available in the **Security** tab of the GitHub repository.
- Other tools provide CLI outputs or reports that can be reviewed manually.

By integrating these tools, this project ensures a robust security posture throughout the development lifecycle.

## Infrastructure as Code

### Deployment Instructions

#### Prerequisites
- AWS CLI installed and configured.
- Terraform installed (v1.0+).

#### Authentication
To deploy this infrastructure, you need to authenticate with AWS. Do **NOT** commit credentials to the repository.

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
   ./setup-backend.sh # For Linux/Mac
   ```
   ```bash
   ./setup-backend.ps1 # For Windows
   ```

2. Navigate to the Terraform directory:
   ```bash
   cd terraform
   ```

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Plan the deployment:
   ```bash
   terraform plan
   ```

5. Apply the configuration:
   ```bash
   terraform apply
   ```

After successful deployment, the API Gateway URL will be displayed in the outputs. You can access the SimpleTimeService through this URL.

### Infrastructure Overview
This Terraform configuration creates:
- **VPC**: With 2 public and 2 private subnets.
- **Lambda Function**: Running in private subnets.
- **API Gateway**: To provide public access to the service.
- **Amazon ECR**: For storing container images.
- **IAM Roles and Policies**: For secure access control.
- **Security Groups**: For network-level security.

The infrastructure uses a container image from Amazon ECR that is maintained through the CI/CD pipeline.

## CI/CD Pipeline
The project uses GitHub Actions for continuous integration and deployment:
- **Build and Test**: Runs on every push and pull request.
- **Security Scanning**: Checks for vulnerabilities.
- **Docker Image Building**: Creates and pushes the container image to Docker Hub and Amazon ECR.
- **Terraform Deployment**: Provisions and updates the AWS infrastructure.

### CI/CD Workflow
The workflow is triggered on:
- Pushes to the `main` or `dev` branch that modify app code, Terraform code, Dockerfile, or CI/CD configuration.
- Pull requests to the `main` branch.

## Security Scan Results
Please find the security scan results at:
[Security Scan Results](https://github.com/ankur008t/Ankur-Particle41-Test/security/code-scanning/tools/CodeQL/status)

## Live Demo
The SimpleTimeService is currently deployed and accessible at:

[Simple Time Service](https://dp21vbdhtb.execute-api.us-east-1.amazonaws.com/dev/)

This endpoint returns a JSON response with the current timestamp and your IP address.

## Contributing
1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m 'Add some feature'
   ```
4. Push to the branch:
   ```bash
   git push origin feature/your-feature-name
   ```
5. Open a pull request.

*This project was created as part of the Particle41 technical assessment.*

