#  AWS Auto Scaling + ALB Infrastructure using Terraform

##  Project Overview

This project demonstrates how to design and deploy a **highly available and scalable AWS infrastructure** using Terraform with a modular approach.

The infrastructure automatically distributes incoming traffic across multiple EC2 instances and scales based on demand, ensuring **high availability, fault tolerance, and performance**.

---

## 🧠 Architecture Summary

* Custom VPC with CIDR block
* Public and Private Subnets across multiple Availability Zones
* Internet Gateway for public access
* NAT Gateway for secure outbound access from private subnets
* Application Load Balancer (ALB) for traffic distribution
* Target Group for managing EC2 instances
* Auto Scaling Group (ASG) for dynamic scaling
* Windows EC2 instances with IIS installed via user data

---

## 🔄 How It Works

1. User sends request → ALB (public subnet)
2. ALB forwards request → Target Group
3. Target Group routes → EC2 instances (private subnet)
4. EC2 responds with its IP (via IIS page)
5. Auto Scaling adjusts number of instances based on demand
6. NAT Gateway allows private EC2 instances to access the internet

---

## 🎯 Key Features

✔️ Multi-AZ architecture (High Availability)
✔️ Load balancing using ALB
✔️ Auto Scaling (Min: 2, Desired: 3, Max: 4)
✔️ Private EC2 instances (secure architecture)
✔️ IIS auto-install using user-data script
✔️ Dynamic response to verify load balancing

---

## 📁 Project Structure

```
autoscaling-alb-project/
│
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
│
├── modules/
│   ├── vpc/
│   ├── subnet/
│   ├── igw/
│   ├── nat/
│   ├── route-table/
│   ├── security-group/
│   ├── alb/
│   ├── launch-template/
│   └── autoscaling/
│
└── userdata/
    └── install_iis.ps1
```

---

## ⚙️ Prerequisites

* AWS Account
* IAM User with sufficient permissions
* Terraform installed
* AWS CLI configured

---

## Setup Instructions (Step-by-Step)

### 1️⃣ Clone Repository

```bash
git clone https://github.com/your-username/Devops_Practice_Aws.git
cd autoscaling-alb-project
```

---

### 2️⃣ Initialize Terraform

```bash
terraform init
```

---

### 3️⃣ Validate Configuration

```bash
terraform validate
```

---

### 4️⃣ Preview Infrastructure

```bash
terraform plan
```

---

### 5️⃣ Deploy Infrastructure

```bash
terraform apply
```

Type `yes` when prompted.

---

## 🌐 Access the Application

After deployment:

1. Go to Terraform output
2. Copy `alb_dns`
3. Open in browser:

```
http://<alb_dns>
```

---

## 🔁 Expected Output

Refresh multiple times:

```
Handled by EC2: 10.0.X.X
```

✔️ IP changes → Load balancing working
✔️ Multiple EC2 → Auto scaling working

---

##  Verification Checklist

* ALB is active and accessible
* Target group shows healthy instances
* Auto Scaling Group has running instances
* Route tables configured correctly
* NAT Gateway is available

---

## ⚠️ Important Notes

* EC2 instances are in **private subnet**
* No public IP assigned to EC2
* ALB is the only public entry point
* NAT Gateway is used for outbound internet access

---

## 🧠 What You Learn

* Real-world AWS architecture design
* Terraform modular structure
* Load balancing concepts
* Auto scaling implementation
* Secure networking (public vs private subnets)

---


## 🙌 Conclusion

This project simulates a **production-level AWS environment**, helping understand how scalable and fault-tolerant systems are built using Infrastructure as Code.

---

#DevOps #AWS #Terraform #CloudComputing
