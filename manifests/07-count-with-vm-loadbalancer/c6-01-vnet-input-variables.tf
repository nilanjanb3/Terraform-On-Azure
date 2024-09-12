# Input Variables for Virtual Network
# -----------------------------
variable "vnet_name" {
  description = <<-EOT
    Virtual Network Name
    -----------------------------
    This variable is used to set the name of the Virtual Network
    that will be created in Azure.
  EOT
  type        = string
  default     = "vnet-default"
}

variable "vnet_address_space" {
  description = <<-EOT
    Address Space for Vnet
    -----------------------------
    This variable is used to set the address space for the Virtual Network
    that will be created in Azure.
  EOT
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

# Input Variables for Web Tier Subnet
# -----------------------------
variable "web_subnet_name" {
  description = <<-EOT
    Web Tier Subnet Name
    -----------------------------
    This variable is used to set the name of the Web Tier subnet
    that will be created in Azure.
  EOT
  type        = string
  default     = "websubnet"
}

variable "web_subnet_address_space" {
  description = <<-EOT
    Web Subnet Address Space
    -----------------------------
    This variable is used to set the address space for the Web Tier subnet
    that will be created in Azure.
  EOT
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

# Input Variables for App Tier Subnet
# -----------------------------
variable "app_subnet_name" {
  description = <<-EOT
    App Tier Subnet Name
    -----------------------------
    This variable is used to set the name of the App Tier subnet
    that will be created in Azure.
  EOT
  type        = string
  default     = "appsubnet"
}

variable "app_subnet_address_space" {
  description = <<-EOT
    App Subnet Address Space
    -----------------------------
    This variable is used to set the address space for the App Tier subnet
    that will be created in Azure.
  EOT
  type        = list(string)
  default     = ["10.0.11.0/24"]
}

# Input Variables for DB Tier Subnet
# -----------------------------
variable "db_subnet_name" {
  description = <<-EOT
    DB Tier Subnet Name
    -----------------------------
    This variable is used to set the name of the DB Tier subnet
    that will be created in Azure.
  EOT
  type        = string
  default     = "dbsubnet"
}

variable "db_subnet_address_space" {
  description = <<-EOT
    DB Subnet Address Space
    -----------------------------
    This variable is used to set the address space for the DB Tier subnet
    that will be created in Azure.
  EOT
  type        = list(string)
  default     = ["10.0.21.0/24"]
}

# Input Variables for Bastion (Management) Subnet
# -----------------------------
variable "bastion_subnet_name" {
  description = <<-EOT
    Bastion (Management) Subnet Name
    -----------------------------
    This variable is used to set the name of the Bastion (Management) subnet
    that will be created in Azure.
  EOT
  type        = string
  default     = "AzureBastionSubnet"
}

variable "bastion_subnet_address_space" {
  description = <<-EOT
    Bastion Subnet Address Space
    -----------------------------
    This variable is used to set the address space for the Bastion (Management) subnet
    that will be created in Azure.
  EOT
  type        = list(string)
  default     = ["10.0.100.0/24"]
}