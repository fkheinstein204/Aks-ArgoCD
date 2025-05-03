terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.27.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.2"
    }
  }

 backend "azurerm" {
     resource_group_name  = "rg-tfstate"
    storage_account_name = "st5zsrajvq"
    container_name       = "tfstate"
    key                  = "aks-tf.tfstate"
  }
}