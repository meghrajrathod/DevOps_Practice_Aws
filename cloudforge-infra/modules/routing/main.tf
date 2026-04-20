# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
}

# Associate Public Subnets
resource "aws_route_table_association" "public_1" {
  subnet_id      = var.public_subnet_1
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = var.public_subnet_2
  route_table_id = aws_route_table.public_rt.id
}

# Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = var.vpc_id

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_id
}

# Associate Private Subnets
resource "aws_route_table_association" "private_1" {
  subnet_id      = var.private_subnet_1
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = var.private_subnet_2
  route_table_id = aws_route_table.private_rt.id
}