#!/bin/bash

VPC_ID=$(cat vpc_id.txt)

echo "Creating Internet Gateway..."

IGW_ID=$(aws ec2 create-internet-gateway \
--query 'InternetGateway.InternetGatewayId' \
--output text)

echo "Internet Gateway Created: $IGW_ID"

aws ec2 attach-internet-gateway \
--internet-gateway-id $IGW_ID \
--vpc-id $VPC_ID

echo "Internet Gateway attached to VPC"

echo $IGW_ID > igw_id.txt