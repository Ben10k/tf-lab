resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-tf-rg"
  location = var.location
}
