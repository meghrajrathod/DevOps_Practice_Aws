# Terraform AWS VPC Project (Public + Private Architecture)

## Overview

This project demonstrates a **production-style AWS infrastructure** built using **Terraform**.
It includes a custom VPC with public and private subnets, EC2 instances, NAT Gateway, and secure network communication using a bastion host approach.

---

## Architecture

```
Internet
   ↓
Internet Gateway
   ↓
Public Subnet
   ├── Public EC2 (Bastion Host)
   └── NAT Gateway
          ↓
      Private Subnet
          └── Private EC2 (No Public Access)
```

---

## Technologies Used

* Terraform
* AWS EC2
* AWS VPC
* NAT Gateway
* Internet Gateway
* Security Groups
* SSH (Key Pair Authentication)

---

## Project Structure

```
terraform/
│
├── main.tf              # Core infrastructure (VPC, EC2, NAT, etc.)
├── variables.tf         # Input variables
├── terraform.tfvars     # Variable values
├── outputs.tf           # Output values (e.g., public IP)
├── provider.tf          # AWS provider config
├── versions.tf          # Terraform & provider versions
├── backend.tf           # Backend config (optional)
├── data.tf              # Fetch existing AWS data
├── locals.tf            # Reusable values
│
├── .terraform/          # Provider plugins (auto-generated)
├── terraform.tfstate    # Infrastructure state (DO NOT SHARE)
├── .terraform.lock.hcl  # Dependency lock file
│
├── devops-key           # Private key (DO NOT COMMIT)
├── devops-key.pub       # Public key
└── .gitignore           # Ignore sensitive files
```

---

## Key Features

### Custom VPC

* CIDR: `10.0.0.0/16`

### Subnets

* Public Subnet → Internet access
* Private Subnet → No direct internet access

### Internet Gateway

* Enables public subnet connectivity

### NAT Gateway

* Allows private EC2 to access internet securely

### EC2 Instances

* Public EC2 (Bastion Host)
* Private EC2 (No public IP)

### Security Groups

* SSH + HTTP rules
* Controlled access between instances

---

## How Everything Works Together

### Public Access

* User connects to **Public EC2** using SSH
* Public EC2 has:

  * Public IP
  * Internet Gateway access

---

### Private Access (Bastion Flow)

* From Public EC2 → SSH into Private EC2
* Private EC2:

  * Has NO public IP
  * Is only accessible internally

---

### Internet for Private EC2

Private EC2 → NAT Gateway → Internet Gateway → Internet

✔ Private EC2 can:

* Install packages
* Access internet APIs
  But cannot be accessed from outside

---

## SSH Access Flow

### Step 1: Connect to Public EC2

```bash
ssh -i devops-key ec2-user@<public-ip>
```

### Step 2: Connect to Private EC2

```bash
ssh -i devops-key ec2-user@<private-ip>
```

---

## Deployment Steps

### 1. Initialize Terraform

```bash
terraform init
```

### 2. Plan Infrastructure

```bash
terraform plan
```

### 3. Apply Configuration

```bash
terraform apply
```

---

## Destroy Infrastructure (IMPORTANT)

To avoid AWS charges:

```bash
terraform destroy
```

---

## Security Notes

* Never commit:

  * `devops-key`
  * `terraform.tfstate`
* Use `.gitignore`
* Restrict SSH access in production

---

##  Learning Outcomes

By building this project, you understand:

* VPC networking in AWS
* Public vs Private subnet design
* NAT Gateway usage
* Bastion host architecture
* Terraform state management
* Infrastructure as Code (IaC)

---

## 📈 Future Improvements

* Remote backend (S3 + DynamoDB)
* Load Balancer (ALB)
* Auto Scaling Group
* CI/CD pipeline integration
* Secure Security Groups (no 0.0.0.0/0)

---

## 👨‍💻 Author

**Meghraj Rathod**
DevOps Learner 🚀

---
