resource "azurerm_subnet" "bastionsubnet" {
  name                 = var.bastion_subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.bastion_subnet_address_space
}

resource "azurerm_network_security_group" "bastionnsg" {
  name                = "${azurerm_subnet.bastionsubnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "bastion_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.bastionsubnet.id
  network_security_group_id = azurerm_network_security_group.bastionnsg.id
  depends_on                = [azurerm_network_security_rule.bastion_nsg_rule]
}

locals {
  bastion_inbound_ports_map = {
    "100" : "22"
    "110" : "3389"
  }
}
resource "azurerm_network_security_rule" "bastion_nsg_rule" {
  for_each                    = local.bastion_inbound_ports_map
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
  network_security_group_name = azurerm_network_security_group.bastionnsg.name

}
