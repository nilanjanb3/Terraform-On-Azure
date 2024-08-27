# Create a subnet for the database tier
resource "azurerm_subnet" "dbsubnet" {
  name                 = var.db_subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.db_subnet_address_space
}

# Create a network security group for the database tier
resource "azurerm_network_security_group" "dbnsg" {
  name                = "${azurerm_subnet.dbsubnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Associate the network security group with the subnet
resource "azurerm_subnet_network_security_group_association" "db_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.dbsubnet.id
  network_security_group_id = azurerm_network_security_group.dbnsg.id
  depends_on                = [azurerm_network_security_rule.db_nsg_rule]
}

# Create a local map of inbound ports for the database tier
locals {
  db_inbound_ports_map = {
    # MySQL
    "100" : "3306"
    # SQL Server
    "110" : "1433"
    # PostgreSQL
    "120" : "5432"
  }
}

# Create a network security rule for each of the inbound ports
resource "azurerm_network_security_rule" "db_nsg_rule" {
  for_each                    = local.db_inbound_ports_map
  name                        = "Rule-${each.value}"
  priority                    = each.key
  access                      = "Allow"
  protocol                    = "Tcp"
  direction                   = "Inbound"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  destination_port_range      = each.value
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.dbnsg.name

}

