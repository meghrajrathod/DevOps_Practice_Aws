variable "vpc_id" {
  description = "VPC ID for attaching the VPN Gateway"
  type        = string
}

variable "customer_gateway_ip" {
  description = "Public IPv4 address of your local/customer gateway"
  type        = string
}

variable "bgp_asn" {
  description = "BGP ASN for customer gateway"
  type        = number
  default     = 65000
}