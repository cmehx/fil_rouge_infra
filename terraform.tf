terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm",
      version = "~> 3.0"
    }
  }

  required_version = ">= 0.14.9"

  backend "azurerm" {
    for_each             = var.environments
    resource_group_name  = "StorageAccount-ResourceGroup"
    storage_account_name = "storage_account_${each.key}"
    container_name       = "tfstate"
    key                  = "${each.key}.terraform.tfstate"
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}



data "azurerm_client_config" "current" {}