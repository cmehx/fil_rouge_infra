terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm",
      version = "~> 3.0"
    }
  }

  required_version = ">= 0.14.9"

  backend "azurerm" {
    resource_group_name  = "fil_rouge_grp_test"
    storage_account_name = "tfstatefilrougetest"
    container_name       = "terraformfilrouge"
    key                  = "terraformfilrouge.tfstate"
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
