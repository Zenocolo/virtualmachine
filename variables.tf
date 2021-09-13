variable "location" {
  description = "Location of the Resource Group"
}

variable "rg-name" {
  description = "Resource Group name"
}

variable "username" {
  description = "Username for Virtual Machines"
}

variable "password" {
  description = "Password for Virtual Machines"
}

variable "vmsize" {
  description = "Size of the VMs"
}

variable "subnet_id" {
  description = "Reference to assigned subnet"
}
