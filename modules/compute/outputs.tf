output "nic_ids" {
  value = azurerm_network_interface.app[*].id
}

output "private_ips" {
  value = azurerm_network_interface.app[*].private_ip_address
}

output "nic_names" {
  value = azurerm_network_interface.app[*].name
}

output "ip_configuration_names" {
  value = [
    for nic in azurerm_network_interface.app :
    nic.ip_configuration[0].name
  ]
}