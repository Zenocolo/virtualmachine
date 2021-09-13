variable "location" {
  description = "Location of the network"
  default     = "westeurope"
}

variable "username" {
  description = "Username for Virtual Machines"
  default     = "testadmin"
}

variable "password" {
  description = "Password for Virtual Machines"
  default     = "Password1234!"
}

variable "vmsize" {
  description = "Size of the VMs"
  default     = "Standard_DS1_v2"
}

variable "subnet_id" {
  description = "Reference to assigned subnet"
  default     = "/subscriptions/65ed073b-97bd-4fb8-a098-f1a6aaeb32f9/resourceGroups/abb-800xa-europe-vnet-rg/providers/Microsoft.Network/virtualNetworks/ABB-SN-GLB-PROD-Z1A-VNET01/subnets/eu-project1"
}
