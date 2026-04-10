# 🌐 Networking Architecture

## VPC

* CIDR: 172.16.0.0/16

---

## Subnet Isolation

### Public Subnets

* Internet-facing
* Used for ALB and Bastion

### Private App Subnets

* No direct internet access
* Use NAT Gateway

### Private DB Subnets

* Fully isolated
* No internet access

---

## NAT Gateway

* Enables outbound internet for private EC2
* Located in public subnet

---

## Traffic Flow

User → ALB → App EC2 → RDS

---

## Availability Zones

* Multi-AZ architecture
* Ensures high availability

---

## Key Benefits

* Secure architecture
* Scalable design
* Fault tolerance
