############################################
# VPC
############################################
module "vpc" {
  source = "./modules/vpc"

  cidr = var.vpc_cidr
  tags = local.common_tags
}

############################################
# PUBLIC SUBNET
############################################
module "subnet" {
  source = "./modules/subnet"

  vpc_id = module.vpc.vpc_id
  cidr   = var.public_subnet_cidr
  az     = var.availability_zone
  tags   = local.common_tags
}

############################################
# INTERNET GATEWAY
############################################
module "igw" {
  source = "./modules/internet-gateway"

  vpc_id = module.vpc.vpc_id
  tags   = local.common_tags
}

############################################
# ROUTE TABLE (PUBLIC)
############################################
module "route_table" {
  source = "./modules/route-table"

  vpc_id    = module.vpc.vpc_id
  igw_id    = module.igw.igw_id
  subnet_id = module.subnet.subnet_id
  tags = local.common_tags

  depends_on = [module.igw]  # 🔥 Important for correct order
}

############################################
# SECURITY GROUP
############################################
module "sg" {
  source = "./modules/security-group"

  vpc_id = module.vpc.vpc_id
  my_ip  = var.my_ip
}

############################################
# WINDOWS EC2
############################################
module "ec2" {
  source = "./modules/ec2-windows"

  subnet_id     = module.subnet.subnet_id
  sg_id         = module.sg.sg_id
  instance_type = var.instance_type
  key_name      = var.key_name

  depends_on = [module.route_table]  # 🔥 Ensures internet ready before EC2
}