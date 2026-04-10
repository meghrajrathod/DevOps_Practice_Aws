# 🛠️ Step-by-Step AWS 3-Tier Architecture Setup

## 1. VPC Creation

* Created VPC with CIDR: `172.16.0.0/16`
* Enabled DNS hostnames and resolution

---

## 2. Subnet Creation

### Public Subnets

* `public-subnet-1a` → 172.16.1.0/24
* `public-subnet-1b` → 172.16.2.0/24

### Private App Subnets

* `private-app-subnet-1a` → 172.16.3.0/24
* `private-app-subnet-1b` → 172.16.4.0/24

### Private DB Subnets

* `private-db-subnet-1a` → 172.16.5.0/24
* `private-db-subnet-1b` → 172.16.6.0/24

---

## 3. Internet Gateway

* Created and attached IGW to VPC

---

## 4. NAT Gateway

* Created in public subnet
* Attached Elastic IP
* Used for outbound internet from private subnets

---

## 5. Route Tables

### Public Route Table

* `0.0.0.0/0 → IGW`

### Private App Route Table

* `0.0.0.0/0 → NAT Gateway`

### Private DB Route Table

* Only local route

---

## 6. EC2 Instances

### Bastion Host (Public)

* Windows Server
* Used for RDP access

### App Servers (Private)

* 2 EC2 instances
* Installed IIS using user data

---

## 7. Load Balancer

* Application Load Balancer
* Attached to public subnets
* Connected to private EC2 via Target Group

---

## 8. RDS Database

* MySQL engine
* Private DB subnet group
* No public access

---

## 9. Security Groups

* ALB SG → allow HTTP from internet
* App SG → allow HTTP from ALB SG
* DB SG → allow MySQL from App SG

---

## 10. Testing

* ALB DNS working
* Load balancing verified
* DB connection successful via EC2
