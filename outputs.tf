output "resource_group" {
  value = azurerm_resource_group.main.name
}

output "vm_private_ips" {
  value = module.compute.private_ips
}

output "application_gateway_public_ip" {
  value = module.app_gateway.public_ip
}


output "nat_public_ip" {
  value = module.nat.nat_public_ip
}

output "storage_account" {
  value = module.storage.storage_account_name
}

output "storage_queue" {
  value = module.storage.queue_name
}