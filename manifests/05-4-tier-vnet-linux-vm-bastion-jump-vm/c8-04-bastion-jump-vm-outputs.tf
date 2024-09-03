output "bastion_vm_public_ip" {
  value = azurerm_linux_virtual_machine.bastion_vm.public_ip_address

}
