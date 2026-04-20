output "vpn_gateway_id" {
  value = aws_vpn_gateway.vgw.id
}

output "customer_gateway_id" {
  value = aws_customer_gateway.cgw.id
}

output "vpn_connection_id" {
  value = aws_vpn_connection.vpn.id
}