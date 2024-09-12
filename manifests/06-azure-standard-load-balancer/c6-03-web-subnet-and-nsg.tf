# Create a subnet for the web tier
resource "azurerm_subnet" "websubnet" {
  # Set the name of the subnet
  name                 = var.web_subnet_name

  # Set the resource group name
  resource_group_name  = azurerm_resource_group.rg.name

  # Set the virtual network name
  virtual_network_name = azurerm_virtual_network.vnet.name

  # Set the address prefixes for the subnet
  address_prefixes     = var.web_subnet_address_space
}

# Create a network security group for the web tier
resource "azurerm_network_security_group" "webnsg" {
  # Set the name of the network security group
  name                = "${azurerm_subnet.websubnet.name}-nsg"

  # Set the location of the network security group
  location            = azurerm_resource_group.rg.location

  # Set the resource group name
  resource_group_name = azurerm_resource_group.rg.name
}

# Associate the network security group with the subnet
resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_association" {
  # Set the subnet id
  subnet_id                 = azurerm_subnet.websubnet.id

  # Set the network security group id
  network_security_group_id = azurerm_network_security_group.webnsg.id

  # Set the depends on attribute to create the network security rules after the network security group is created
  depends_on                = [azurerm_network_security_rule.web_nsg_rule]
}

# Create a local map of inbound ports for the web tier
locals {
  web_inbound_ports_map = {
    "100" : "22"
    "110" : "80"
    "120" : "443"
  }
}

# Create a network security rule for each inbound port
resource "azurerm_network_security_rule" "web_nsg_rule" {
  # Iterate over the local map of inbound ports
  for_each                    = local.web_inbound_ports_map

  # Set the name of the network security rule
  name                        = "Rule-${each.value}"

  # Set the priority of the network security rule
  priority                    = each.key

  # Set the access attribute to allow
  access                      = "Allow"

  # Set the protocol attribute to Tcp
  protocol                    = "Tcp"

  # Set the direction attribute to Inbound
  direction                   = "Inbound"

  # Set the source port range attribute to *
  source_port_range           = "*"

  # Set the source address prefix attribute to *
  source_address_prefix       = "*"

  # Set the destination address prefix attribute to *
  destination_address_prefix  = "*"

  # Set the destination port range attribute to the value of the local map
  destination_port_range      = each.value

  # Set the resource group name attribute to the resource group name
  resource_group_name         = azurerm_resource_group.rg.name

  # Set the network security group name attribute to the network security group name
  network_security_group_name = azurerm_network_security_group.webnsg.name
}

