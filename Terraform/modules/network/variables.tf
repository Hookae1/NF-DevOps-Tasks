variable "rgroup" {
  type = object({
    name     = string
    location = string
  })
  description = "Resource Group"
}

variable "prefix" {
  type        = string
  description = "Project name"
}

variable "vnet_adspace" {
  type        = list(string)
  description = "Vnet address space"
}

variable "subnet_adspace" {
  type        = list(string)
  description = "Subnet addres space"
}

variable "public_ip" {
  type = object({
    allocation_method = string
    version           = string
    sku               = string
  })
  description = "IP address"
}

variable "nsgrule" {
  type = list(object({
    name                       = string
    priority                   = number
    destination_port_range     = string
    direction                  = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    access                     = string
  }))
  description = "NSG rules"
}