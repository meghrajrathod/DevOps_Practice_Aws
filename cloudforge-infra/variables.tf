variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "domain_name" {
  default = "meghrajrathod.cloud"
}

variable "my_ip" {
  type = string
}

variable "customer_gateway_ip" {
  type = string
}