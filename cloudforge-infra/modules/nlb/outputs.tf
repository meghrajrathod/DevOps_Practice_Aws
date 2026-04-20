output "lb_dns" {
  value = aws_lb.nlb.dns_name
}

output "lb_zone_id" {
  value = aws_lb.nlb.zone_id
}

output "target_group_arn" {
  value = aws_lb_target_group.tg.arn
}