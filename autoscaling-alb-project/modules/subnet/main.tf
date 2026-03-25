resource "aws_subnet" "public_1a" {
  vpc_id = var.vpc_id
  cidr_block = var.public_cidr_1a
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
  Name = "public-subnet-1a"
}
}


resource "aws_subnet" "public_1b" {
  vpc_id = var.vpc_id
  cidr_block = var.public_cidr_1b
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-1b"
  } 
}

resource "aws_subnet" "private_1a" {
  vpc_id = var.vpc_id
  cidr_block = var.private_cidr_1a
  availability_zone = "us-east-1a"
  tags = {
  Name = "private-subnet-1a"
}
}

resource "aws_subnet" "private_1b" {
  vpc_id = var.vpc_id
  cidr_block = var.private_cidr_1b
  availability_zone = "us-east-1b"
  tags = {
  Name = "private-subnet-1b"
}
}