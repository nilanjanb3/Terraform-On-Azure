# This block configures the Terraform version and required provider versions

terraform {
  # Require Terraform version 1.0.0 or newer
  required_version = ">= 1.0.0"

  # Require the AzureRM provider version 3.114.0 or newer
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.114.0"
    }
  }
}

# This block configures the AzureRM provider

provider "azurerm" {
  # Enable all available features for the AzureRM provider
  features {}
}

# This resource block creates a new resource group in Azure

resource "azurerm_resource_group" "terraform_rg" {
  # Set the name of the resource group
  name = "terraform-rg"

  # Set the location of the resource group
  location = "Central India"

  # Set tags for the resource group
  tags = {
    Environment = "Dev"
    Team        = "DevOps"
    Owner       = "Nilanjan"
    Project     = "Terraform"
    Usage       = "Terraform Remote State"
  }
}

# This resource block creates a new storage account in Azure

resource "azurerm_storage_account" "terraform_storage" {
  # Set the name of the storage account
  name = "nilanjanremotetfstate"

  # Set the resource group name for the storage account
  resource_group_name = azurerm_resource_group.terraform_rg.name

  # Set the location of the storage account
  location = azurerm_resource_group.terraform_rg.location

  # Set the account tier for the storage account
  account_tier = "Standard"

  # Set the account replication type for the storage account
  account_replication_type = "LRS"

  # Set tags for the storage account
  tags = {
    Environment = "Dev"
    Team        = "DevOps"
    Owner       = "Nilanjan"
    Project     = "Terraform"
    Usage       = "Terraform Remote State"
  }
}

