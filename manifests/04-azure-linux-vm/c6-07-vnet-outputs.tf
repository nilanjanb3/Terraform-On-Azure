# Output the Virtual Network Name
output "virtual_network_name" {
  description = "The name of the Virtual Network"
  value       = azurerm_virtual_network.vnet.name
}

# Output the Virtual Network ID
output "virtual_network_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

# Output the Web Tier Subnet Name
output "web_subnet_name" {
  description = "The name of the Web Tier Subnet"
  value       = azurerm_subnet.websubnet.name
}

# Output the Web Tier Subnet ID
output "web_subnet_id" {
  description = "The ID of the Web Tier Subnet"
  value       = azurerm_subnet.websubnet.id
}

# Output the Web Tier Network Security Group Name
output "web_subnet_nsg_name" {
  description = "The name of the Web Tier Network Security Group"
  value       = azurerm_network_security_group.webnsg.name
}

# Output the Web Tier Network Security Group ID
output "web_subnet_nsg_id" {
  description = "The ID of the Web Tier Network Security Group"
  value       = azurerm_network_security_group.webnsg.id
}

