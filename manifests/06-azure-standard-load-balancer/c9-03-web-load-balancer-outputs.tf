output "web_lb_public_ip" {

  value = azurerm_public_ip.web_loadbalancer_frontend_pip.ip_address

}

output "web_lb_id" {
  value = azurerm_lb.web_loadbalancer.id
}

output "web_lb_frontend_ip_config" {
  value = [azurerm_lb.web_loadbalancer.frontend_ip_configuration]
}
