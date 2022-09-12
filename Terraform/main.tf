# Create resource group
resource "azurerm_resource_group" "toohes_rg" {
  name                = var.rgroup.name
  location            = var.rgroup.location
}

# Calling module - network
module "network" {
source                = "./modules/network"
  
  prefix              = var.prefix
  rgroup              = var.rgroup

  vnet_adspace        = var.vnet_adspace
  subnet_adspace      = var.subnet_adspace
  public_ip           = var.public_ip
  nsgrule             = var.nsgrule

depends_on            = [azurerm_resource_group.toohes_rg]    
}

# Calling module - VM
module "vm" {
source                = "./modules/vm"

  prefix              = var.prefix
  rgroup              = var.rgroup
  nic_id              = [module.network.nic_id]

  vm                  = var.vm
  admin_username      = var.admin_username
  key_vault           = var.key_vault
  pub_key             = var.pub_key
  size                = var.size

}
