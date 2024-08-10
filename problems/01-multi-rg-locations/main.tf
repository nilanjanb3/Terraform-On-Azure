terraform {
  required_version = ">=1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.115.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# resource "azurerm_resource_group" "rgs" {
#   for_each = var.rg-locations
#   name     = each.key
#   location = each.value
# }

resource "azurerm_resource_group" "rgs" {
  for_each = var.rg-locations-2
  name     = each.key
  location = each.value.location
  tags     = each.value.tags

}
