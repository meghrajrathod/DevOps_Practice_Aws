#!/bin/bash

echo "Creating VPC..."

VPC_ID=$(aws ec2 create-vpc \
--cidr-block 10.0.0.0/16 \
--query 'Vpc.VpcId' \
--output text)

echo "VPC Created: $VPC_ID"

aws ec2 create-tags \
--resources $VPC_ID \
--tags Key=Name,Value=DevOps-VPC

echo $VPC_ID > vpc_id.txt

echo "VPC ID saved to vpc_id.txt"