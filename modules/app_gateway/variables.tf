variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "app_gateway_subnet_id" {
  type = string
}

variable "backend_private_ips" {
  type = list(string)
}