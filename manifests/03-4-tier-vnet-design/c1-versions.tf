# Configure the Terraform version and provider versions
terraform {
  required_providers {
    # Configure the AzureRM provider
    azurerm = {
      source  = "hashicorp/azurerm"
      # Use the latest version of the provider that is >= 4.0.0
      version = "~>4.0.0"
    }
    # Configure the Random provider
    random = {
      source  = "hashicorp/random"
      # Use the latest version of the provider that is >= 3.6.0
      version = "~>3.6.0"
    }
  }
}

# Configure the AzureRM provider
provider "azurerm" {
  # Enable all features for the AzureRM provider
  features {}

  # Set the Azure subscription ID
  subscription_id = var.azure_subscription_id
}

