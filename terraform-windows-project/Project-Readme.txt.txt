# Terraform AWS Windows Infrastructure Project

## About This Project

This project demonstrates how to create a complete AWS infrastructure using **Terraform with a modular structure**.

The infrastructure includes:

* VPC (Virtual Private Cloud)
* Public Subnet
* Internet Gateway
* Route Table
* Security Group
* Windows EC2 Instance

The EC2 instance is configured with:

* **IIS (Internet Information Services)**
* **Apache Web Server**

---

## How It Works

1. Terraform creates a **VPC** to isolate the network.
2. A **Public Subnet** is created inside the VPC.
3. An **Internet Gateway** is attached to allow internet access.
4. A **Route Table** is configured to route traffic to the internet.
5. A **Security Group** is created to allow:

   * RDP (3389)
   * HTTP (80)
6. A **Windows EC2 instance** is launched inside the subnet.
7. Using **user-data script**:

   * IIS is installed
   * Apache is downloaded and configured

---

## Architecture Flow

VPC → Subnet → Route Table → Internet Gateway → EC2 (Windows + IIS + Apache)

---

## Use of This Project

* Learn **Terraform modular structure**
* Understand **AWS networking basics**
* Practice **real-world DevOps infrastructure setup**
* Deploy a **Windows-based web server**
* Useful for **DevOps beginners and portfolio projects**

---

## Technologies Used

* Terraform
* AWS (EC2, VPC, Networking)
* Windows Server
* IIS & Apache

---

## How to Run

```bash
terraform init
terraform plan
terraform apply
```

After deployment:

* Use EC2 Public IP to access IIS in browser
* Use RDP to connect to Windows server

---

## Author

**Meghraj Rathod**

---

## Notes

* Make sure your AWS credentials are configured
* Key pair must exist in the same region
* Do not delete resources manually (use `terraform destroy`)
