terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.114.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "terraform_rg" {
  name     = "terraform-rg"
  location = "Central India"

  tags = {
    Environment = "Dev"
    Team        = "DevOps"
    Owner       = "Nilanjan"
    Project     = "Terraform"
    Usage       = "Terraform Remote State"
  }
}

resource "azurerm_storage_account" "terraform_storage" {
  name                     = "nilanjanremotetfstate"
  resource_group_name      = azurerm_resource_group.terraform_rg.name
  location                 = azurerm_resource_group.terraform_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    Environment = "Dev"
    Team        = "DevOps"
    Owner       = "Nilanjan"
    Project     = "Terraform"
    Usage       = "Terraform Remote State"
  }

}
