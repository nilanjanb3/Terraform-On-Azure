# Web Linux VM NSG

resource "azurerm_network_security_group" "web_linux_vm_nsg" {
    name = "${azurerm_network_interface.web_linux_vm_nic.name}-nsg"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
  
}

resource "azurerm_network_interface_security_group_association" "web_linux_vm_nsg_association" {
    network_interface_id = azurerm_network_interface.web_linux_vm_nic.id
    network_security_group_id = azurerm_network_security_group.web_linux_vm_nsg.id
    depends_on = [ azurerm_network_security_rule.web_linux_vm_nsg_rule ]
  
}

resource "azurerm_network_security_rule" "web_linux_vm_nsg_rule" {
    for_each = local.web_inbound_ports_map
    name = "Rule-${each.value}"
    priority = each.key
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = each.value
    source_address_prefix = "*"
    destination_address_prefix = "*"
    resource_group_name = azurerm_resource_group.rg.name
    network_security_group_name = azurerm_network_security_group.web_linux_vm_nsg.name
  
}