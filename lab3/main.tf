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


module "linuxservers" {
  source = "Azure/compute/azurerm"

  resource_group_name = azurerm_resource_group.rg.name
  vm_os_simple        = "UbuntuServer"
  vnet_subnet_id      = module.network.subnet_id
  vm_size             = "Standard_B1ls"
  nb_instances        = var.vm_count

  depends_on = [azurerm_resource_group.rg]
}
