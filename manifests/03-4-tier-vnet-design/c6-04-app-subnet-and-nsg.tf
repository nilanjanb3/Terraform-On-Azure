resource "azurerm_subnet" "appsubnet" {
  name                 = var.app_subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.app_subnet_address_space
}

resource "azurerm_network_security_group" "appnsg" {
  name                = "${azurerm_subnet.appsubnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "app_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.appsubnet.id
  network_security_group_id = azurerm_network_security_group.appnsg.id
  depends_on                = [azurerm_network_security_rule.app_nsg_rule]
}

locals {
  app_inbound_ports_map = {
    "100" : "22"
    "110" : "80"
    "120" : "443"
    "130" : "8080"
  }
}
resource "azurerm_network_security_rule" "app_nsg_rule" {
  for_each                    = local.app_inbound_ports_map
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
  network_security_group_name = azurerm_network_security_group.appnsg.name

}
