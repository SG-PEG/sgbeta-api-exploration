terraform {
  cloud {
    organization = "sg-StephensGroup"
    workspaces {
      name = "sgbeta-azure-api-exploration"
    }
  }
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.15.0"
    }
  }
}


provider "azurerm" {
  features {}
  subscription_id = "767929a3-4907-4361-b821-55d749ffb306"
}