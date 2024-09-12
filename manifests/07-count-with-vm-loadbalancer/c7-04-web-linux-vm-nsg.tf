# Web Linux VM NSG

resource "azurerm_network_security_group" "web_linux_vm_nsg" {
  count               = var.web_linux_vm_count
  name                = "${element(azurerm_network_interface.web_linux_vm_nic[*].name, count.index)}-nsg-${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  dynamic "security_rule" {
    for_each = local.web_inbound_ports_map
    content {
      name                       = "Rule-${security_rule.value}"
      priority                   = security_rule.key
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

}

resource "azurerm_network_interface_security_group_association" "web_linux_vm_nsg_association" {
  count                     = var.web_linux_vm_count
  network_interface_id      = element(azurerm_network_interface.web_linux_vm_nic[*].id, count.index)
  network_security_group_id = element(azurerm_network_security_group.web_linux_vm_nsg[*].id, count.index)
  #   depends_on                = [azurerm_network_security_rule.web_linux_vm_nsg_rule]


}
