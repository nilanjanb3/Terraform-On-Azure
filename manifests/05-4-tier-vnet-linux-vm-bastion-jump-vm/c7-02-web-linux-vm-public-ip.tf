# Resource block for web Linux VM Piublic Ip

resource "azurerm_public_ip" "web_linux_vm_pip" {
    name = "${local.resource_name_prefix}-web-linux-vm-pip"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    allocation_method = "Static"
    domain_name_label = "web-app-01"
  
}

