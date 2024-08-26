output "virtual_network_name" {
  description = "Virtual Network Name"
  value       = azurerm_virtual_network.vnet.name
}

output "virtual_network_id" {
  description = "Virtual Network ID"
  value       = azurerm_virtual_network.vnet.id

}
output "web_subnet_name" {
  description = "Web Tier Subnet Name"
  value       = azurerm_subnet.websubnet.name
}
output "web_subnet_id" {
  description = "Web Tier Subnet Id"
  value       = azurerm_subnet.websubnet.id

}

output "web_subnet_nsg_name" {
  description = "Web Tier NSG name"
  value       = azurerm_network_security_group.webnsg.name
}

output "web_subnet_nsg_id" {
  description = "Web Tier NSG Id"
  value       = azurerm_network_security_group.webnsg.id

}
