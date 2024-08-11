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


# This resource block creates multiple resource groups in Azure, one for each element in the map variable "rg-locations-2".
# The resource group name is obtained from the keys of the map, and the location and tags from the corresponding values.
# The "for_each" meta-argument is used to iterate over the elements of the map.
# The "each" object is a map where the keys are the keys of the map variable, and the values are objects containing the corresponding values.
# The "name" attribute is set to the key of the map element, the "location" attribute is set to the "location" property of the value object,
# and the "tags" attribute is set to the "tags" property of the value object.
resource "azurerm_resource_group" "rgs" {
  # Iterate over the elements of the map variable "rg-locations-2"
  for_each = var.rg-locations-2

  # Set the name of the resource group to the key of the map element
  name = each.key

  # Set the location of the resource group to the "location" property of the value object
  location = each.value.location

  # Set the tags of the resource group to the "tags" property of the value object
  tags = each.value.tags

}
