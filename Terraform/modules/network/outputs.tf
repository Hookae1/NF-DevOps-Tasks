output "vnet_name" {
  value   = azurerm_virtual_network.toohes_vnet.name
  description = "Fetch vnet name"
}

output "nic_id" {
  value = azurerm_network_interface.toohes_nic.id
  description = "Fetch NIC ID for vm module"
}