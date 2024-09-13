resource "azurerm_subnet" "bastion_vm_subnet" {
  name                 = var.bastion_vm_subnet_name
  address_prefixes     = var.bastion_vm_subnet_address_space
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name

}


resource "azurerm_network_security_group" "bastion_vm_subnet_nsg" {
  name                = "${azurerm_subnet.bastion_vm_subnet.name}-nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

}


resource "azurerm_subnet_network_security_group_association" "bastion_vm_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.bastion_vm_subnet.id
  network_security_group_id = azurerm_network_security_group.bastion_vm_subnet_nsg.id
  depends_on                = [azurerm_network_security_rule.bastion_vm_subnet_nsg_rule]

}

locals {
  bastion_vm_subnet_nsg_rule_mapping = {
    # SSH
    "110" : {
      "Port" = "22"
      "Type" = "Inbound"
    }
    # RDP
    "120" : {
      "Port" = "3389"
      "Type" = "Inbound"
    }
  }
}
resource "azurerm_network_security_rule" "bastion_vm_subnet_nsg_rule" {
  # Iterate over the local map of inbound ports
  for_each = local.bastion_vm_subnet_nsg_rule_mapping

  # The name of the network security rule
  name = "Rule-${each.value.Port}-${each.value.Type}"

  # The priority of the network security rule
  priority = each.key

  # The access attribute
  access = "Allow"

  # The protocol attribute
  protocol = "Tcp"

  # The direction attribute
  direction = each.value.Type

  # The source port range attribute
  source_port_range = "*"

  # The source address prefix attribute
  source_address_prefix = "*"

  # The destination address prefix attribute
  destination_address_prefix = "*"

  # The destination port range attribute
  destination_port_range = each.value.Port

  # The resource group name attribute
  resource_group_name = azurerm_resource_group.rg.name

  # The network security group name attribute
  network_security_group_name = azurerm_network_security_group.bastion_vm_subnet_nsg.name

}

resource "azurerm_public_ip" "bastion_vm_pip" {
  name                = "bastion_vm_pip"
  sku                 = "Standard"
  allocation_method   = "Static"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  domain_name_label   = "bastionvm-01"

}

resource "azurerm_network_interface" "bastion_vm_nic" {
  name                = "bastion_vm_nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "bastion_vm_pip_config"
    subnet_id                     = azurerm_subnet.bastion_vm_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion_public_ip.id

  }

}

resource "azurerm_network_security_group" "bastion_vm_nic_nsg" {
  name                = "bastion_linux_vm_nic_nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

}
resource "azurerm_network_interface_security_group_association" "bastion_vm_nic_nsg_association" {
  network_interface_id      = azurerm_network_interface.bastion_vm_nic.id
  network_security_group_id = azurerm_network_security_group.bastion_vm_nic_nsg.id
  depends_on                = [azurerm_network_security_rule.bastion_vm_nic_nsg_rule]
}


locals {
  bastion_vm_nic_nsg_rule_mapping = {
    # SSH
    "110" : {
      "Port" = "22"
      "Type" = "Inbound"
    }
  }
}


resource "azurerm_network_security_rule" "bastion_vm_nic_nsg_rule" {
  # Iterate over the local map of inbound ports
  for_each = local.bastion_vm_nic_nsg_rule_mapping

  # The name of the network security rule
  name = "Rule-${each.value.Port}-${each.value.Type}"

  # The priority of the network security rule
  priority = each.key

  # The access attribute
  access = "Allow"

  # The protocol attribute
  protocol = "Tcp"

  # The direction attribute
  direction = each.value.Type

  # The source port range attribute
  source_port_range = "*"

  # The source address prefix attribute
  source_address_prefix = "*"

  # The destination address prefix attribute
  destination_address_prefix = "*"

  # The destination port range attribute
  destination_port_range = each.value.Port

  # The resource group name attribute
  resource_group_name = azurerm_resource_group.rg.name

  # The network security group name attribute
  network_security_group_name = azurerm_network_security_group.bastion_vm_nic_nsg.name

}
