# Resource block for creating the Web Linux VM Custom Data


# Resource block for creating the Web Linux VM

resource "azurerm_ssh_public_key" "web_linux_vm_ssh_key" {
  name                = "web-linux-vm-ssh-key"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  public_key          = file("${path.module}/ssh-keys/terraform-azure.pub")

}

resource "azurerm_linux_virtual_machine" "web_linux_vm" {
  count = var.web_linux_vm_count
  name  = "${local.resource_name_prefix}-web-linux-vm-01-${count.index}"
  # computer_name         = "web-linux-vm-01"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = "Standard_DS1_v2"
  admin_username        = "azureuser"
  network_interface_ids = [element(azurerm_network_interface.web_linux_vm_nic[*].id, count.index)]

  admin_ssh_key {
    username   = "azureuser"
    public_key = azurerm_ssh_public_key.web_linux_vm_ssh_key.public_key
  }

  os_disk {
    name                 = "${local.resource_name_prefix}-web-linux-vm-${count.index}-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }
  custom_data = filebase64("${path.module}/app-scripts/install-httpd-rhel.sh")
}

