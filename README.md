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
  - [Locally](#locally)
  - [Using Docker](#using-docker)
- [Testing](#testing)
- [Security Scanning](#security-scanning)
- [Infrastructure as Code](#infrastructure-as-code)
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
│   ├── variables.tf      # Variable definitions
│   └── outputs.tf        # Output definitions
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
Clone the repository:
```bash
git clone https://github.com/ankur008t/Ankur-Particle41-Test.git
cd Ankur-Particle41-Test
```

Install dependencies:
```bash
pip install -r requirements.txt
```

## Running the Application

### Locally
Navigate to the app directory:
```bash
cd app
```

Run the application:
```bash
python main.py
```

Access the service at http://localhost:8000/

### Using Docker
Build the Docker image:
```bash
docker build -t simpletimeservice .
```

Run the container:
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
The project includes Terraform configurations to deploy the application to AWS:

Navigate to the terraform directory:
```bash
cd terraform
```

Initialize Terraform:
```bash
terraform init
```

Plan the deployment:
```bash
terraform plan
```

Apply the configuration:
```bash
terraform apply
```

The infrastructure includes:
- VPC with public and private subnets
- ECS/EKS cluster for container orchestration
- Load balancer for public access
- Security groups and IAM roles

## CI/CD Pipeline
The project uses GitHub Actions for continuous integration and deployment:

- Build and Test: Runs on every push and pull request
- Security Scanning: Checks for vulnerabilities
- Docker Image Building: Creates and tests the container image

## Contributing
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Commit your changes: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature/your-feature-name`
5. Open a pull request

This project was created as part of the Particle41 technical assessment.