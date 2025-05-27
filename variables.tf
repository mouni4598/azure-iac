variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}
variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "address_space" {
  description = "Address space for VNet"
  type        = list(string)
}

variable "vm_subnet_name" {
  description = "Name of VM subnet"
  type        = string
}

variable "vm_subnet_prefix" {
  description = "CIDR block of VM subnet"
  type        = string
}

variable "appgw_subnet_name" {
  description = "Name of Application Gateway subnet"
  type        = string
}

variable "appgw_subnet_prefix" {
  description = "CIDR block of App Gateway subnet"
  type        = string
}
variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "vm_size" {
  description = "Size of the VM (e.g., Standard_B2ms)"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
}
variable "managed_identity_principal_id" {
  type        = string
  description = "The principal ID of the managed identity"
}
variable "tenant_id" {
  description = "The tenant ID for the Key Vault"
  type        = string
}
variable "appgw_name" {
  description = "The name of the Application Gateway"
  type        = string
  default     = "arc-test-gateway"
}

variable "appgw_public_ip_name" {
  description = "The name of the Public IP for Application Gateway"
  type        = string
  default     = "arc-test-gateway-ip"
}





