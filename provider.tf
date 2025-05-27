# provider "azurerm" {
#   features {}

#   subscription_id = var.subscription_id
# }
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.44.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

