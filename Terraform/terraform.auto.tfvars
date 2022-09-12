key_vault = "/subscriptions/ffb73868-4b1b-470d-9b78-a54281355cc1/resourceGroups/nf-test/providers/Microsoft.KeyVault/vaults/nfVault"
pub_key   = "moonkeypub"

rgroup = {
  name     = "moon-rg"
  location = "eastus"
}

prefix = "moon"

vnet_adspace = ["10.0.0.0/16"]

subnet_adspace = ["10.0.0.0/24"]

public_ip = {
  allocation_method = "Static"
  version           = "IPv4"
  sku               = "Standard"
}

nsgrule = [
  {
    name                       = "ssh-22"
    priority                   = 100
    destination_port_range     = "22"
    direction                  = "Inbound"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    access                     = "Allow"
  },
  {
    name                       = "http-80"
    priority                   = 101
    destination_port_range     = "80"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    access                     = "Allow"
  },
  {
    name                       = "allow-out"
    priority                   = 100
    destination_port_range     = "*"
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    access                     = "Allow"
  }
]

size = "Standard_B2s"

admin_username = "moonuser"

vm = {
  image = {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  disk = {
    name                 = "moondisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}
