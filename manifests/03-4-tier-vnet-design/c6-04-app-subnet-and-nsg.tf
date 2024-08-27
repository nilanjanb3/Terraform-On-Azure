# Create a subnet for the App Tier
resource "azurerm_subnet" "appsubnet" {
  # The name of the subnet
  name = var.app_subnet_name

  # The resource group in which to create the subnet
  resource_group_name = azurerm_resource_group.rg.name

  # The virtual network in which to create the subnet
  virtual_network_name = azurerm_virtual_network.vnet.name

  # The address prefixes for the subnet
  address_prefixes = var.app_subnet_address_space
}

# Create a network security group for the App Tier
resource "azurerm_network_security_group" "appnsg" {
  # The name of the network security group
  name = "${azurerm_subnet.appsubnet.name}-nsg"

  # The location of the network security group
  location = azurerm_resource_group.rg.location

  # The resource group in which to create the network security group
  resource_group_name = azurerm_resource_group.rg.name
}

# Associate the network security group with the subnet
resource "azurerm_subnet_network_security_group_association" "app_subnet_nsg_association" {
  # The subnet id
  subnet_id = azurerm_subnet.appsubnet.id

  # The network security group id
  network_security_group_id = azurerm_network_security_group.appnsg.id

  # Create the network security rules after the network security group is created
  depends_on = [azurerm_network_security_rule.app_nsg_rule]
}

# Create a local map of inbound ports
locals {
  app_inbound_ports_map = {
    # SSH
    "100" = "22"

    # HTTP
    "110" = "80"

    # HTTPS
    "120" = "443"

    # Tomcat
    "130" = "8080"
  }
}

# Create a network security rule for each of the inbound ports
resource "azurerm_network_security_rule" "app_nsg_rule" {
  # Iterate over the local map of inbound ports
  for_each = local.app_inbound_ports_map

  # The name of the network security rule
  name = "Rule-${each.value}"

  # The priority of the network security rule
  priority = each.key

  # The access attribute
  access = "Allow"

  # The protocol attribute
  protocol = "Tcp"

  # The direction attribute
  direction = "Inbound"

  # The source port range attribute
  source_port_range = "*"

  # The source address prefix attribute
  source_address_prefix = "*"

  # The destination address prefix attribute
  destination_address_prefix = "*"

  # The destination port range attribute
  destination_port_range = each.value

  # The resource group name attribute
  resource_group_name = azurerm_resource_group.rg.name

  # The network security group name attribute
  network_security_group_name = azurerm_network_security_group.appnsg.name
}

