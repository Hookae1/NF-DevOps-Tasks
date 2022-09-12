output "resource_group" {
  value = azurerm_resource_group.toohes_rg.name
  description = "Fetch resource group name from root module"
}

output "location" {
  value = azurerm_resource_group.toohes_rg.location
  description = "Fetch resource group location from root module"
}

output "public_ip" {
  value = module.vm.public_ip
  description = "Fetch Public IP fomr module - vm"
}

output "user_name" {
  value = module.vm.admin_username
  sensitive = true
  description = "Fetch VM name from module - vm"
}

output "host_name" {
  value = module.vm.host_name
  description = "Fetch admin username from module - vm"
}

output "vnet_name" {
  value = module.network.vnet_name
  description = "Fetch vnet-name from module - vnet"
}
