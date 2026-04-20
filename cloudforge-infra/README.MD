# CloudForge Infra — AWS 3 Tier Architecture

A production-style AWS 3 tier architecture built using Terraform to understand real world cloud infrastructure, networking and scalability.
![AWS](https://img.shields.io/badge/AWS-Cloud-FF9900)
![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4)
![Windows](https://img.shields.io/badge/EC2-Windows-blue)
![AutoScaling](https://img.shields.io/badge/Scaling-Automatic-green)

## Features

- Modular Terraform project structure
- Public and private subnet architecture
- Bastion host for secure access
- Windows EC2 instances with IIS hosting
- Auto Scaling Group for high availability
- Network Load Balancer for traffic distribution
- Route 53 domain integration
- NAT Gateway for private subnet internet access
- Site to Site VPN setup

## Tech Stack

| Component | Technology |
|-----------|------------|
| Cloud     | AWS |
| IaC       | Terraform |
| Compute   | EC2 Windows |
| Scaling   | Auto Scaling Group |
| Load Balancer | Network Load Balancer |
| Networking | VPC, Subnets, IGW, NAT |
| DNS       | Route 53 |
| Security  | Security Groups, Bastion |
| Web Server | IIS |

## Project Structure


cloudforge-infra
│
├── main.tf
├── variables.tf
├── terraform.tfvars
│
└── modules
├── vpc
├── subnets
├── internet_gateway
├── nat_gateway
├── routing
├── security_groups
├── ec2
├── autoscaling
├── nlb
├── route53
└── vpn


## Workflow

User → Route 53 → Network Load Balancer → Target Group → Auto Scaling EC2 → IIS Website

- User opens domain
- Route 53 resolves DNS
- Request goes to Network Load Balancer
- NLB forwards traffic to target group
- Target group routes to Auto Scaling EC2 instances
- IIS serves the website from private instances

## Quick Start

### Initialize Terraform

```bash
terraform init
Validate Configuration
terraform validate
Apply Infrastructure
terraform apply -auto-approve
Key Components
VPC

Creates isolated network environment

Subnets

Public for Bastion, Private for application

Bastion Host

Used for secure access to private EC2

Auto Scaling Group

Maintains and scales EC2 instances automatically

Network Load Balancer

Distributes incoming traffic across instances

Route 53

Handles domain routing

NAT Gateway

Provides internet access to private instances

Challenges
Linux and Windows AMI confusion
Load balancer health check issues
IIS setup on Windows EC2
Terraform module linking errors
Duplicate resource creation during setup
Future Improvements
Add HTTPS using AWS Certificate Manager
Setup CI CD pipeline
Add monitoring with CloudWatch
Improve frontend UI
Project Link

https://github.com/meghrajrathod/DevOps_Practice_Aws/tree/master/cloudforge-infra

Author

Meghraj Rathod