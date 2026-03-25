variable "vpc_cidr" {}
variable "public_cidr_1a" {}
variable "public_cidr_1b" {}
variable "private_cidr_1a" {}
variable "private_cidr_1b" {}

variable "key_name" {}

variable "instance_type" {
  default = "t3.micro"
}