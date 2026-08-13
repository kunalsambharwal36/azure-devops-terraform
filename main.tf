
module "networking" {
  source = "./modules/networking"

  resource_group_name = var.resource_group_name
  location            = var.location
}

module "security" {
  source = "./modules/security"

  resource_group_name = var.resource_group_name
  location            = var.location
  backend_subnet_id   = module.networking.backend_subnet_id
}

module "nat" {
  source = "./modules/nat"

  resource_group_name = var.resource_group_name
  location            = var.location
  backend_subnet_id   = module.networking.backend_subnet_id
}

module "compute" {
  source = "./modules/compute"

  resource_group_name = var.resource_group_name
  location            = var.location

  backend_subnet_id = module.networking.backend_subnet_id

  admin_username = var.admin_username
  ssh_public_key = var.ssh_public_key
  vm_size        = var.vm_size
}


module "app_gateway" {
  source = "./modules/app_gateway"

  resource_group_name = var.resource_group_name
  location            = var.location

  app_gateway_subnet_id = module.networking.app_gateway_subnet_id
  backend_private_ips   = module.compute.private_ips
}

module "storage" {
  source = "./modules/storage"

  resource_group_name = var.resource_group_name
  location            = var.location
}