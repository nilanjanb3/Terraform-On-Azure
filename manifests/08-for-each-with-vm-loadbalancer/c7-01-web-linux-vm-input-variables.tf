# Variable file for web Linux VM public ip

# variable "web_linux_vm_count" {
#   description = "Number of web Linux VMs to deploy"
#   type        = number
#   default     = 1

# }

# variable "lb_inbount_nat_ports" {
#   description = "List of inbound ports for load balancer"
#   type        = list(number)
#   default     = [1022, 2022, 3022, 4022, 5022]

# }

variable "web_linux_vm_inbount_nat_port_map" {
  type = map(string)

  default = {
    "vm1" = "1022",
    "vm2" = "2022"
  }
  
}