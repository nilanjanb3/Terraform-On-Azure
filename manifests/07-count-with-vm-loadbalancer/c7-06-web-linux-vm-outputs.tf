# Public IP Outputs
# output "web_linux_vm_pip" {
#     value = azurerm_public_ip.web_linux_vm_pip.ip_address
# }

# NIC Outputs

output "web_linux_vm_nic_id" {
  value = azurerm_network_interface.web_linux_vm_nic[*].id
}

output "web_linux_vm_nic_private_ip" {
  value = [azurerm_network_interface.web_linux_vm_nic[*].private_ip_addresses]
}

# Linux VM Outputs

output "web_linux_vm_id" {
  value = azurerm_linux_virtual_machine.web_linux_vm[*].id
}

output "web_linux_vm_128bit_id" {
  value = azurerm_linux_virtual_machine.web_linux_vm[*].virtual_machine_id

}

# output "web_linux_vm_public_ip" {
#   value = azurerm_linux_virtual_machine.web_linux_vm[*].public_ip_address
# }

output "web_linux_vm_private_ip" {
  value = azurerm_linux_virtual_machine.web_linux_vm[*].private_ip_address
}
