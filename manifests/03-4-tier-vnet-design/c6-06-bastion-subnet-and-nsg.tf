# Create a subnet for the bastion host
resource "azurerm_subnet" "bastionsubnet" {
  # The name of the subnet
  name = var.bastion_subnet_name

  # The resource group in which to create the subnet
  resource_group_name = azurerm_resource_group.rg.name

  # The virtual network in which to create the subnet
  virtual_network_name = azurerm_virtual_network.vnet.name

  # The address prefixes for the subnet
  address_prefixes = var.bastion_subnet_address_space
}

# Create a network security group for the bastion host
resource "azurerm_network_security_group" "bastionnsg" {
  # The name of the network security group
  name = "${azurerm_subnet.bastionsubnet.name}-nsg"

  # The location of the network security group
  location = azurerm_resource_group.rg.location

  # The resource group in which to create the network security group
  resource_group_name = azurerm_resource_group.rg.name
}

# Associate the network security group with the subnet
resource "azurerm_subnet_network_security_group_association" "bastion_subnet_nsg_association" {
  # The subnet id
  subnet_id = azurerm_subnet.bastionsubnet.id

  # The network security group id
  network_security_group_id = azurerm_network_security_group.bastionnsg.id

  # Do the association after the network security group and subnet are created
  depends_on = [azurerm_network_security_rule.bastion_nsg_rule]
}

# Create a local map of inbound ports for the bastion host
locals {
  bastion_inbound_ports_map = {
    # SSH
    "100" = "22"

    # RDP
    "110" = "3389"
  }
}

# Create a network security rule for each of the inbound ports
resource "azurerm_network_security_rule" "bastion_nsg_rule" {
  # Iterate over the local map of inbound ports
  for_each = local.bastion_inbound_ports_map

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
  network_security_group_name = azurerm_network_security_group.bastionnsg.name
}


# Locals block for naming conventions
locals {
  # Naming convention for the Bastion Public IP
  bastion_public_ip_name = "bastionpublicip"

  # Naming convention for the Bastion Host
  bastion_host_name = "bastionhost"

  # Naming convention for the Bastion IP Configuration
  bastion_ip_configuration_name = "bastionipconfig"
}

# Resource block for creating the Bastion Public IP
# This is a static, standard SKU Public IP
resource "azurerm_public_ip" "bastion_public_ip" {
  # Name of the Public IP
  name                = local.bastion_public_ip_name
  # Location of the Public IP
  location            = azurerm_resource_group.rg.location
  # Resource group in which the Public IP is created
  resource_group_name = azurerm_resource_group.rg.name
  # Allocation method for the Public IP
  allocation_method   = "Static"
  # SKU of the Public IP
  sku                 = "Standard"
}

# Resource block for creating the Bastion Host
# This is a managed service for securely accessing Azure Virtual Machines
resource "azurerm_bastion_host" "name" {
  # Resource group in which the Bastion Host is created
  resource_group_name = azurerm_resource_group.rg.name
  # Name of the Bastion Host
  name = local.bastion_host_name
  # Location of the Bastion Host
  location = azurerm_resource_group.rg.location
  # IP configuration of the Bastion Host
  ip_configuration {
    # Name of the IP Configuration
    name                 = local.bastion_ip_configuration_name
    # Subnet ID to which the Bastion Host is associated
    subnet_id            = azurerm_subnet.bastionsubnet.id
    # Public IP Address ID associated with the Bastion Host
    public_ip_address_id = azurerm_public_ip.bastion_public_ip.id
  }
}
