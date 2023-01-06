terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm",
            version = "~> 3.0"
        }
        random = {
            source = "hashicorp/random"
            version = "2.3.0"
        }
    }

    required_version = ">= 0.14.9"
}

provider "azurerm" {
    features {}
}
