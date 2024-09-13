resource "azurerm_ssh_public_key" "bastion_linux_vm_ssh_key" {
  name                = "bastion-linux-vm-ssh-key"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  public_key          = file("${path.module}/ssh-keys/terraform-azure.pub")

}

resource "azurerm_linux_virtual_machine" "bastion_vm" {
  name                = "bastion-linux-vm-01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  admin_username      = "azureuser"
  size                = "Standard_B2s"

  network_interface_ids = [azurerm_network_interface.bastion_vm_nic.id]
  admin_ssh_key {
    username   = "azureuser"
    public_key = azurerm_ssh_public_key.bastion_linux_vm_ssh_key.public_key
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

resource "null_resource" "bastion_vm_actions" {
  connection {
    type        = "ssh"
    host        = azurerm_linux_virtual_machine.bastion_vm.public_ip_address
    user        = "azureuser"
    private_key = file("${path.module}/ssh-keys/terraform-azure.pem")
  }
  provisioner "file" {
    source      = "${path.module}/ssh-keys/terraform-azure.pem"
    destination = "/tmp/terraform-azure.pem"
    on_failure  = fail
  }
  provisioner "remote-exec" {
    inline     = ["sudo chmod 400 /tmp/terraform-azure.pem"]
    on_failure = fail
  }

}
