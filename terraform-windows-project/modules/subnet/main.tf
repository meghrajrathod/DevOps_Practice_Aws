resource "aws_subnet" "this" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr
  availability_zone       = var.az
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "dev-public-subnet"
  })
}