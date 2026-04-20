output "bastion_ip" {
  value = module.ec2.bastion_public_ip
}

output "website_url" {
  value = module.nlb.lb_dns
}

output "route53_nameservers" {
  value = module.route53.name_servers
}