terraform {
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm",
        version = "~> 2.65"
      }
    }

    required_version = ">= 0.14.9"
}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "resourcegroups" {
    name        = var.ResourceGroup
    location    = var.Location
}

resource "azurerm_container_registry" "acr" {
  name                = "filRougeRegistry"
  resource_group_name = var.ResourceGroup
  location            = var.Location
  sku                 = "Standard"
  admin_enabled       = false
}