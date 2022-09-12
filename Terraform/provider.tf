terraform {
  required_version = ">= 1.1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  backend "azurerm" {
    resource_group_name  = "nf-test"
    storage_account_name = "moonstoragestate"
    container_name       = "moonstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
