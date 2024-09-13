# # Public IP Outputs
# # output "web_linux_vm_pip" {
# #     value = azurerm_public_ip.web_linux_vm_pip.ip_address
# # }

# # NIC Outputs

# output "web_linux_vm_nic_id" {
#   value = azurerm_network_interface.web_linux_vm_nic[*].id
# }

# output "web_linux_vm_nic_private_ip" {
#   value = [azurerm_network_interface.web_linux_vm_nic[*].private_ip_addresses]
# }

# # Linux VM Outputs

# output "web_linux_vm_id" {
#   value = azurerm_linux_virtual_machine.web_linux_vm[*].id
# }

# output "web_linux_vm_128bit_id" {
#   value = azurerm_linux_virtual_machine.web_linux_vm[*].virtual_machine_id

# }

# # output "web_linux_vm_public_ip" {
# #   value = azurerm_linux_virtual_machine.web_linux_vm[*].public_ip_address
# # }

# output "web_linux_vm_private_ip" {
#   value = azurerm_linux_virtual_machine.web_linux_vm[*].private_ip_address
# }

# Output List - Single Input to for loop
output "web_linux_vm_private_ip_addresses_list" {
  description = "List of private IP addresses of the web Linux VMs"
  value = [for vm in azurerm_linux_virtual_machine.web_linux_vm : vm.private_ip_address]
  
}

# Output Map  - Single Input to for loop
output "web_linux_vm_private_ip_addresses_map" {
  description = "Map of private IP addresses of the web Linux VMs"
  value = {for vm in azurerm_linux_virtual_machine.web_linux_vm : vm.name => vm.private_ip_address}
}

# Terraform keys() function: keys takes a map and returns a list containing the keys from that map.
output "web_linuxvm_private_ip_address_keys_function" {
  description = "List of private IP addresses of the web Linux VMs"
  value = keys({for vm in azurerm_linux_virtual_machine.web_linux_vm : vm.name => vm.private_ip_address})
}

# Terraform values() function: values takes a map and returns a list containing the values of the elements in that map.
output "web_linuxvm_private_ip_address_values_function" {
  description = "List of private IP addresses of the web Linux VMs"
  value = values({for vm in azurerm_linux_virtual_machine.web_linux_vm : vm.name => vm.private_ip_address})
}

# Output List - Two Inputs to for loop (here vm is Iterator like "i")
output "web_linuxvm_network_interface_id_list" {
  description = "List of private IP addresses of the web Linux VMs"
  value = [for vm, nic in azurerm_network_interface.web_linux_vm_nic : nic.id]
}

# Output Map  - Two Inputs to for loop (here vm is Iterator like "i")
output "web_linuxvm_network_interface_id_map" {
  description = "List of private IP addresses of the web Linux VMs"
  value = {for vm, nic in azurerm_network_interface.web_linux_vm_nic: vm => nic.id}

}