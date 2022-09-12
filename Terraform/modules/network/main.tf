locals {
  vnet_name = "${var.prefix}-vnet"
}

# Create virtual network
resource "azurerm_virtual_network" "toohes_vnet" {
  name                = local.vnet_name
  address_space       = var.vnet_adspace
  location            = var.rgroup.location
  resource_group_name = var.rgroup.name
}

# Create subnet
resource "azurerm_subnet" "toohes_sub" {
  name                 = "${var.prefix}-subnet"
  address_prefixes     = var.subnet_adspace
  virtual_network_name = local.vnet_name
  resource_group_name  = var.rgroup.name
  depends_on           = [azurerm_virtual_network.toohes_vnet]
}

# Create Public IPs
resource "azurerm_public_ip" "toohes_ip" {
  name                = "${var.prefix}-pbip"
  resource_group_name = var.rgroup.name
  location            = var.rgroup.location
  allocation_method   = var.public_ip.allocation_method
  ip_version          = var.public_ip.version
  sku                 = var.public_ip.sku
}

# Create NSG and NSG-rules
resource "azurerm_network_security_group" "toohes_nsg" {
  name                = "${var.prefix}-nsg"
  resource_group_name = var.rgroup.name
  location            = var.rgroup.location

  dynamic "security_rule" {
    for_each = var.nsgrule
    content {
      name                       = security_rule.value["name"]
      priority                   = security_rule.value["priority"]
      direction                  = security_rule.value["direction"]
      access                     = security_rule.value["access"]
      protocol                   = security_rule.value["protocol"]
      source_port_range          = security_rule.value["source_port_range"]
      destination_port_range     = security_rule.value["destination_port_range"]
      source_address_prefix      = security_rule.value["source_address_prefix"]
      destination_address_prefix = security_rule.value["destination_address_prefix"]
    }
  }
}

# Create NIC
resource "azurerm_network_interface" "toohes_nic" {
  name                = "${var.prefix}-nic"
  location            = var.rgroup.location
  resource_group_name = var.rgroup.name

  ip_configuration {
    name                          = "public"
    subnet_id                     = azurerm_subnet.toohes_sub.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.toohes_ip.id
  }
}

# Create association NIC with NSG
resource "azurerm_network_interface_security_group_association" "association" {
  network_interface_id      = azurerm_network_interface.toohes_nic.id
  network_security_group_id = azurerm_network_security_group.toohes_nsg.id
}
