# This resource block creates a new resource group named "demorg1" in the "southindia" region
resource "azurerm_resource_group" "rg1" {
  # Set the name of the resource group
  name = "demorg1"
  # Set the location of the resource group
  location = "southindia"

  # The resource group is created using the default provider configuration
}

# This resource block creates a new resource group named "demorg2" in the "westindia" region
# The resource group is created using the provider configuration with the alias "provider2-south-india"
resource "azurerm_resource_group" "rg2" {
  # Set the name of the resource group
  name = "demorg2"
  # Set the location of the resource group
  location = "westindia"
  # Set the provider configuration for the resource group
  provider = azurerm.provider2-south-india

}

