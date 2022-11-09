provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-lab3-tf-rg"
  location = var.location
}

module "network" {
  source = "./modules/network"

  location = var.location
  prefix   = var.prefix
  rg_name  = azurerm_resource_group.rg.name
}
