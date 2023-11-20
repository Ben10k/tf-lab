provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-tf-rg"
  location = var.location
}

resource "random_integer" "storage_account_suffix" {
  min = 1000
  max = 9999
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "${var.prefix}storage${random_integer.storage_account_suffix.id}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_replication_type = "LRS"
  account_tier             = "Standard"
}
