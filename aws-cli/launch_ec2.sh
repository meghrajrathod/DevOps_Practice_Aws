#!/bin/bash

PUBLIC_SUBNET=$(cat public_subnet.txt)

echo "Launching EC2 Instance..."

INSTANCE_ID=$(aws ec2 run-instances \
--image-id ami-0c02fb55956c7d316 \
--count 1 \
--instance-type t3.micro \
--subnet-id $PUBLIC_SUBNET \
--associate-public-ip-address \
--query 'Instances[0].InstanceId' \
--output text)

echo "EC2 Instance Created: $INSTANCE_ID"

echo $INSTANCE_ID > instance_id.txt