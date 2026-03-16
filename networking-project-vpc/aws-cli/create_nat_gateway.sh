#!/bin/bash

PUBLIC_SUBNET=$(cat public_subnet.txt)

echo "Allocating Elastic IP..."

EIP_ALLOC=$(aws ec2 allocate-address \
--domain vpc \
--query 'AllocationId' \
--output text)

echo "Elastic IP Allocation: $EIP_ALLOC"

echo "Creating NAT Gateway..."

NAT_ID=$(aws ec2 create-nat-gateway \
--subnet-id $PUBLIC_SUBNET \
--allocation-id $EIP_ALLOC \
--query 'NatGateway.NatGatewayId' \
--output text)

echo "NAT Gateway Created: $NAT_ID"

echo $NAT_ID > nat_gateway_id.txt