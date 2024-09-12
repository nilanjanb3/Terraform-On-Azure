variable "bastion_vm_subnet_name" {
  type    = string
  default = "bastionvmsubnet"
}

variable "bastion_vm_subnet_address_space" {
  type    = list(string)
  default = ["10.1.31.0/27"]
}
