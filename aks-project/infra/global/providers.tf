terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstate<uniquesuffix>"
    container_name       = "tfstate"
    key                  = "walmart-aks.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

