terraform {
    required_providers {
      azurem = {
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
