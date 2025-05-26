variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group to create the VNet in"
  type        = string
}

variable "address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
}

variable "vm_subnet_name" {
  description = "Name of the subnet used for the virtual machine"
  type        = string
}

variable "vm_subnet_prefix" {
  description = "CIDR block for the VM subnet"
  type        = string
}

variable "appgw_subnet_name" {
  description = "Name of the subnet used for Application Gateway"
  type        = string
}

variable "appgw_subnet_prefix" {
  description = "CIDR block for the App Gateway subnet"
  type        = string
}
