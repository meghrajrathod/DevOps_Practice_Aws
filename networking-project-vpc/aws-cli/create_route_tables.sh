#!/bin/bash

VPC_ID=$(cat vpc_id.txt)
IGW_ID=$(cat igw_id.txt)
PUBLIC_SUBNET=$(cat public_subnet.txt)

echo "Creating Public Route Table..."

RT_ID=$(aws ec2 create-route-table \
--vpc-id $VPC_ID \
--query 'RouteTable.RouteTableId' \
--output text)

echo "Route Table: $RT_ID"

aws ec2 create-route \
--route-table-id $RT_ID \
--destination-cidr-block 0.0.0.0/0 \
--gateway-id $IGW_ID

echo "Route added to Internet Gateway"

aws ec2 associate-route-table \
--subnet-id $PUBLIC_SUBNET \
--route-table-id $RT_ID

echo "Route Table associated with Public Subnet"

echo $RT_ID > route_table_id.txt