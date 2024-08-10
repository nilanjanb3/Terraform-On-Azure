resource "azurerm_resource_group" "rg1" {
  name     = "demorg1"
  location = "southindia"

}

resource "azurerm_resource_group" "rg2" {
  name     = "demorg2"
  location = "westindia"
  provider = azurerm.provider2-south-india

}
