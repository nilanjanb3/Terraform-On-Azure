# Configure Terraform version and provider versions

terraform {
  # Require Terraform version 1.0.0 or newer
  required_version = ">=1.0.0"

  # Require the AzureRM provider version 3.115.0
  required_providers {
    # Specify the AzureRM provider source and version
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.115.0"
    }
  }
}

# Configure the AzureRM provider with default settings
provider "azurerm" {
  # Enable all available features for this provider
  features {}
}

# Configure the AzureRM provider with custom settings for the "provider2-south-india" alias
provider "azurerm" {
  # Enable specific features for the "provider2-south-india" alias
  features {
    # Configure the virtual_machine feature settings
    virtual_machine {
      # Disable the deletion of the OS disk when deleting a virtual machine
      delete_os_disk_on_deletion = false
    }
  }

  # Set the alias for this provider configuration
  alias = "provider2-south-india"
}

