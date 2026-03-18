# CloudFormation VPC Project – Working Explanation

This project demonstrates how a complete AWS infrastructure works together using CloudFormation. It creates a custom Virtual Private Cloud (VPC) with both public and private networking layers, allowing secure and controlled access to resources.

At the core, a VPC is created to act as an isolated network environment. Inside this VPC, two subnets are defined: a public subnet and a private subnet. The public subnet is configured to allow direct communication with the internet, while the private subnet is restricted and cannot be accessed directly from outside.

An Internet Gateway (IGW) is attached to the VPC, which enables internet connectivity. The public subnet is connected to this gateway through a public route table, allowing resources inside it to communicate with the internet. This is where the public EC2 instance is deployed, acting as a bastion host that can be accessed via SSH.

For the private subnet, a separate route table is created. Instead of directly connecting to the Internet Gateway, it routes traffic through a NAT Gateway. The NAT Gateway is placed in the public subnet and allows instances in the private subnet to access the internet for updates or downloads, while still remaining inaccessible from external users.

Two EC2 instances are launched:

* A public EC2 instance in the public subnet, which has a public IP and can be accessed from the internet.
* A private EC2 instance in the private subnet, which does not have a public IP and can only be accessed through the public EC2 instance.

A security group is configured to allow SSH (port 22) and HTTP (port 80) access, ensuring controlled communication between the instances and external users.

The flow of communication works as follows: external users connect to the public EC2 instance using SSH. From there, they can securely access the private EC2 instance. Meanwhile, the private EC2 can access the internet through the NAT Gateway but cannot be reached directly from outside, maintaining security.

Overall, this setup mimics a real-world production architecture where sensitive resources are kept in private networks while still maintaining controlled access and internet connectivity.

---

##  Author

**Meghraj Rathod**
