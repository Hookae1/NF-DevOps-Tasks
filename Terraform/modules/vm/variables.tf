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

variable "nic_id" {
  type = list(string)
  description = "NIC ID for VM"
}

variable "key_vault" {
    type                            = string
    sensitive                       = true  
}

variable "pub_key" {
    type                            = string
}

variable "vm" {
  type                     = object({
    image                  = object({
      publisher            = string
      offer                = string
      sku                  = string
      version              = string
    })

    disk                   = object({
      name                 = string
      caching              = string
      storage_account_type = string
    })
  })
  description              = "Basic settings for VM"
}

variable "size" {
  type                     = string
  description              = "VM size"
}

variable "admin_username" {
  type                     = string
  sensitive                = true
  description              = "VM username"
}
