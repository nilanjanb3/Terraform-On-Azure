# Create a resource group in Azure
# The name of the resource group is a combination of the business division, environment, and a random string
# The location of the resource group is the value of the `resource_group_location` variable
# The tags of the resource group are the values of the `common_tags` local variable
resource "azurerm_resource_group" "rg" {
  name     = "${local.resource_name_prefix}-${var.resource_group_name}-${random_string.myrandom.id}"
  location = var.resource_group_location
  tags     = local.common_tags
}

