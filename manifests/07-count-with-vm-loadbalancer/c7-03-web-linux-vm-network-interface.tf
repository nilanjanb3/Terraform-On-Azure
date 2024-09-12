# Resource for web Linux VM Network Interface

resource "azurerm_network_interface" "web_linux_vm_nic" {
  count               = var.web_linux_vm_count
  name                = "${local.resource_name_prefix}-web-linux-vm-nic-${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "web-linux-vm-ip"
    subnet_id                     = azurerm_subnet.websubnet.id
    private_ip_address_allocation = "Dynamic"
    # public_ip_address_id          = azurerm_public_ip.web_linux_vm_pip.id
    primary = true
  }

}

