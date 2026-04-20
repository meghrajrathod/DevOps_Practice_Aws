resource "aws_vpn_gateway" "vgw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "main-vpn-gateway"
  }
}

resource "aws_customer_gateway" "cgw" {
  bgp_asn    = var.bgp_asn
  ip_address = var.customer_gateway_ip
  type       = "ipsec.1"

  tags = {
    Name = "main-customer-gateway"
  }
}

resource "aws_vpn_connection" "vpn" {
  vpn_gateway_id      = aws_vpn_gateway.vgw.id
  customer_gateway_id = aws_customer_gateway.cgw.id
  type                = "ipsec.1"

  static_routes_only = true

  tags = {
    Name = "main-site-to-site-vpn"
  }
}