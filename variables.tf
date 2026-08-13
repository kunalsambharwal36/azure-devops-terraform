variable "location" {
  type    = string
  default = "East US"
}

variable "resource_group_name" {
  type    = string
  default = "kml-azure-tf-lab"
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key used for VM authentication"
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}
