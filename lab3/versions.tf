terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "REPLACE with RESOURCE_GROUP_NAME"
    storage_account_name = "REPLACE with STORAGE_ACCOUNT_NAME"
    container_name       = "tfstate"
    key                  = "lab3.tfstate"
  }
}
