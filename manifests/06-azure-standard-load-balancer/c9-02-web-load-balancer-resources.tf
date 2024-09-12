resource "azurerm_public_ip" "web_loadbalancer_frontend_pip" {
  name                = "web-loadbalancer-frontend-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"

}

resource "azurerm_lb" "web_loadbalancer" {
  name                = "web-loadbalancer"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  frontend_ip_configuration {
    name                 = "web-loadbalancer-frontend-pip-config"
    public_ip_address_id = azurerm_public_ip.web_loadbalancer_frontend_pip.id
  }

}

resource "azurerm_lb_backend_address_pool" "web_loadbalancer_backend_pool" {
  name            = "web-loadbalancer-backend-pool"
  loadbalancer_id = azurerm_lb.web_loadbalancer.id
}

resource "azurerm_lb_probe" "web_loadbalancer_probe" {
  name                = "web-loadbalancer-probe"
  loadbalancer_id     = azurerm_lb.web_loadbalancer.id
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 2

}

resource "azurerm_lb_rule" "web_loadbalancer_rule" {
  name                           = "web-loadbalancer-rule"
  loadbalancer_id                = azurerm_lb.web_loadbalancer.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.web_loadbalancer_backend_pool.id]
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "web-loadbalancer-frontend-pip-config"
  probe_id                       = azurerm_lb_probe.web_loadbalancer_probe.id

}

resource "azurerm_network_interface_backend_address_pool_association" "web_loadbalancer_backend_pool_association" {
  network_interface_id    = azurerm_network_interface.web_linux_vm_nic.id
  ip_configuration_name   = azurerm_network_interface.web_linux_vm_nic.ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.web_loadbalancer_backend_pool.id

}

resource "azurerm_lb_nat_rule" "web_loadbalancer_nat_rule" {
  name                           = "web-loadbalancer-nat-rule"
  loadbalancer_id                = azurerm_lb.web_loadbalancer.id
  protocol                       = "Tcp"
  frontend_port                  = 2222
  backend_port                   = 22
  frontend_ip_configuration_name = "web-loadbalancer-frontend-pip-config"

  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_interface_nat_rule_association" "web_linux_vm_nat_rule_association" {
  network_interface_id  = azurerm_network_interface.web_linux_vm_nic.id
  ip_configuration_name = azurerm_network_interface.web_linux_vm_nic.ip_configuration[0].name
  nat_rule_id           = azurerm_lb_nat_rule.web_loadbalancer_nat_rule.id
}
