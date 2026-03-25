module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "subnet" {
  source = "./modules/subnet"

  vpc_id = module.vpc.vpc_id

  public_cidr_1a  = var.public_cidr_1a
  public_cidr_1b  = var.public_cidr_1b
  private_cidr_1a = var.private_cidr_1a
  private_cidr_1b = var.private_cidr_1b
}

module "igw" {
  source = "./modules/igw"
  vpc_id = module.vpc.vpc_id
}

module "nat" {
  source = "./modules/nat"

  public_subnet_id = module.subnet.public_1a_id
}

module "route_table" {
  source = "./modules/route-table"

  vpc_id = module.vpc.vpc_id

  igw_id = module.igw.igw_id
  nat_id = module.nat.nat_id

  public_subnet_ids = [
    module.subnet.public_1a_id,
    module.subnet.public_1b_id
  ]

  private_subnet_ids = [
    module.subnet.private_1a_id,
    module.subnet.private_1b_id
  ]
}

module "security_group" {
  source = "./modules/security-group"
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source = "./modules/alb"

  vpc_id = module.vpc.vpc_id

  public_subnets = [
    module.subnet.public_1a_id,
    module.subnet.public_1b_id
  ]

  sg_id = module.security_group.alb_sg_id
}

module "launch_template" {
  source = "./modules/launch-template"

  key_name      = var.key_name
  instance_type = var.instance_type
  ec2_sg_id     = module.security_group.ec2_sg_id
}

module "autoscaling" {
  source = "./modules/autoscaling"

  private_subnets = [
    module.subnet.private_1a_id,
    module.subnet.private_1b_id
  ]

  launch_template_id = module.launch_template.lt_id
  target_group_arn   = module.alb.target_group_arn
}