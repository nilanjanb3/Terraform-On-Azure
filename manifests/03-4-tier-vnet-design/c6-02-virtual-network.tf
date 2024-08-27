# Create a Virtual Network in Azure
# The name of the Virtual Network is a combination of the business division, environment, and a random string
# The location of the Virtual Network is the value of the `resource_group_location` variable
# The address space of the Virtual Network is the value of the `vnet_address_space` variable
# The tags of the Virtual Network are the values of the `common_tags` local variable
resource "azurerm_virtual_network" "vnet" {
  # The name of the Virtual Network
  name = "${local.resource_name_prefix}-${var.vnet_name}"

  # The resource group in which to create the Virtual Network
  resource_group_name = azurerm_resource_group.rg.name

  # The location of the Virtual Network
  location = azurerm_resource_group.rg.location

  # The address space of the Virtual Network
  address_space = var.vnet_address_space

  # The tags of the Virtual Network
  tags = local.common_tags
}

