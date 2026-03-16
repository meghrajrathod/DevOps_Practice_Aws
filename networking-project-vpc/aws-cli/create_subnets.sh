#!/bin/bash

VPC_ID=$(cat vpc_id.txt)

echo "Creating Public Subnet..."

PUBLIC_SUBNET=$(aws ec2 create-subnet \
--vpc-id $VPC_ID \
--cidr-block 10.0.1.0/24 \
--availability-zone us-east-1a \
--query 'Subnet.SubnetId' \
--output text)

echo "Public Subnet: $PUBLIC_SUBNET"


echo "Creating Private Subnet..."

PRIVATE_SUBNET=$(aws ec2 create-subnet \
--vpc-id $VPC_ID \
--cidr-block 10.0.2.0/24 \
--availability-zone us-east-1b \
--query 'Subnet.SubnetId' \
--output text)

echo "Private Subnet: $PRIVATE_SUBNET"


echo $PUBLIC_SUBNET > public_subnet.txt
echo $PRIVATE_SUBNET > private_subnet.txt