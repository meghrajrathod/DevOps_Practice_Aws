module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "subnets" {
  source = "./modules/subnets"
  vpc_id = module.vpc.vpc_id
}

module "igw" {
  source = "./modules/internet_gateway"
  vpc_id = module.vpc.vpc_id
}

module "nat" {
  source = "./modules/nat_gateway"
  public_subnet_id = module.subnets.public_subnet_1
}

module "routing" {
  source = "./modules/routing"
  vpc_id = module.vpc.vpc_id
  igw_id = module.igw.igw_id
  nat_id = module.nat.nat_id
  public_subnet_1 = module.subnets.public_subnet_1
  public_subnet_2 = module.subnets.public_subnet_2
  private_subnet_1 = module.subnets.private_subnet_1
  private_subnet_2 = module.subnets.private_subnet_2
}

module "sg" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
  my_ip = var.my_ip
}

module "ec2" {
  source = "./modules/ec2"

  public_subnet = module.subnets.public_subnet_1
  sg_bastion    = module.sg.bastion_sg
}

module "autoscaling" {
  source = "./modules/autoscaling"

  private_subnet_1 = module.subnets.private_subnet_1
  private_subnet_2 = module.subnets.private_subnet_2

  sg_app           = module.sg.app_sg
  target_group_arn = module.nlb.target_group_arn
}

module "nlb" {
  source  = "./modules/nlb"
  subnets = [module.subnets.public_subnet_1, module.subnets.public_subnet_2]
  vpc_id  = module.vpc.vpc_id
}

module "route53" {
  source       = "./modules/route53"
  domain_name  = var.domain_name
  lb_dns       = module.nlb.lb_dns
  lb_zone_id   = module.nlb.lb_zone_id
}

module "vpn" {
  source              = "./modules/vpn"
  vpc_id              = module.vpc.vpc_id
  customer_gateway_ip = var.customer_gateway_ip
}