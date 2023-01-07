terraform {
  backend "azurerm" {
    resource_group_name  = "fil_rouge_grp_test"
    storage_account_name = "tfstatefilrougetest"
    container_name       = "terraformfilrouge"
    key                  = "terraformfilrouge.tfstate"
  }
}