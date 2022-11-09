terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "REPLACE with RESOURCE_GROUP_NAME"
    storage_account_name = "REPLACE with STORAGE_ACCOUNT_NAME>"
    container_name       = "tfstate"
    key                  = "lab3.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-tf-rg"
  location = var.location
}

module "network" {
  source = "./modules/network"

  location = var.location
  prefix   = var.prefix
  rg_name  = azurerm_resource_group.rg.name
}

resource "azurerm_network_interface" "server" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.network.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

module "linuxservers" {
  source = "Azure/compute/azurerm"

  resource_group_name = azurerm_resource_group.rg.name
  vm_os_simple        = "UbuntuServer"
  vnet_subnet_id      = module.network.subnet_id
}
