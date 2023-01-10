terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm",
      version = "~> 3.0"
    }
  }

  required_version = ">= 0.14.9"

  backend "azurerm" {
    resource_group_name  = "fil_rouge_grp_devops"
    storage_account_name = "filrougetfstate"
    container_name       = "terraform"
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
provider "azuread" {
  version = "=0.10.0"
}

data "azurerm_client_config" "current" {}
