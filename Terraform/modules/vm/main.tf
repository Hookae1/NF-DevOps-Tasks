#Fetch Azure Key Vault Data (SSH key) for VM configuration
data "azurerm_key_vault_secret" "toohes_key" {
  name         = var.pub_key
  key_vault_id = var.key_vault
}

output "secret_value" {
  value     = data.azurerm_key_vault_secret.toohes_key.value
  sensitive = true
}

# Create Linux VM
resource "azurerm_linux_virtual_machine" "toohes_vm" {
  name                        = "${var.prefix}-vm"
  resource_group_name         = var.rgroup.name
  location                    = var.rgroup.location
  size                        = var.size
  admin_username              = var.admin_username
  network_interface_ids       = var.nic_id

  source_image_reference {
    publisher                 = var.vm.image.publisher
    offer                     = var.vm.image.offer
    sku                       = var.vm.image.sku
    version                   = var.vm.image.version
  }
  os_disk {
    name                      = var.vm.disk.name
    caching                   = var.vm.disk.caching
    storage_account_type      = var.vm.disk.storage_account_type
  }     
  admin_ssh_key {
    username                  = var.admin_username
    public_key                = data.azurerm_key_vault_secret.toohes_key.value
  }
}
# Create inventory file for Ansible
data "template_file" "inventory" {
  template                    = file("_templates/inventory.tpl")

  vars = {
    user                      = var.admin_username
    host                      = join("", [azurerm_linux_virtual_machine.toohes_vm.name, " ansible_host=", azurerm_linux_virtual_machine.toohes_vm.public_ip_address])
  }
}

resource "local_file" "save_inventory" {
  content                     = data.template_file.inventory.rendered
  filename                    = "../Ansible/inventory"
}

resource "azurerm_virtual_machine_extension" "toohes_script" {
  name                 = "${var.prefix}-script"
  virtual_machine_id   = azurerm_linux_virtual_machine.toohes_vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
        "fileUris": ["https://raw.githubusercontent.com/Hookae1/NF-DevOps-Tasks/main/Terraform/Customscrpit/runner.sh"], 
        "commandToExecute": "./runner.sh"
    }
SETTINGS

  timeouts {
    create = "2m"
  }
}
