output "public_ip" {
  value       = azurerm_linux_virtual_machine.toohes_vm.public_ip_address
  description = "Fetch Public IP"
}

output "host_name" {
  value       = azurerm_linux_virtual_machine.toohes_vm.name
  description = "Fetch VM name"
}

output "admin_username" {
  value       = var.admin_username
  sensitive   = true
  description = "Fetch admin username"
}

output "pub_key" {
    value                   = var.pub_key
}
