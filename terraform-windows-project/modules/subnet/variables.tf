variable "vpc_id" {
  type = string
}

variable "cidr" {
  type = string
}

variable "az" {
  type = string
}

variable "tags" {
  type = map(string)
}