# backend-deployment-assessment

## Overview
Terraform + Docker deployment of the MuchTodo Golang backend API on AWS.

## Prerequisites
- AWS CLI configured with valid credentials
- Terraform v1.x installed
- Docker and Docker Compose installed
- SSH key pair created in AWS (startuptech-key)

## Infrastructure
- VPC: 10.0.0.0/16 (startuptech-vpc)
- 2 public subnets, 2 private subnets across 2 AZs
- Internet Gateway, NAT Gateway
- Bastion Host (public), Backend Server (private), MongoDB Server (private)
- Application Load Balancer on port 80 → Backend on port 8080

## Phase 1: Provision Infrastructure
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your IP and AMI ID
nano terraform.tfvars

terraform init
terraform plan
terraform apply

## Phase 2: Run Application Locally

docker build -t muchtodo-backend .
docker compose up -d
curl http://localhost:8080/health
```

## Phase 3: Deploy to EC2

# SSH to Bastion
ssh -i ~/.ssh/startuptech-key.pem ec2-user@BASTION_IP

# SSH to Backend from Bastion
ssh -i ~/.ssh/startuptech-key.pem ec2-user@BACKEND_PRIVATE_IP

# Deploy
docker compose up -d

# Verify via ALB
curl http://ALB_DNS_NAME/health
```

## Teardown (Delete all resources)

cd terraform
terraform destroy
```
