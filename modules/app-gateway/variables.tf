variable "location" {
  description = "Azure location"
  type        = string
}

variable "resource_group_name" {
  description = "Azure resource group name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for Application Gateway"
  type        = string
}

variable "vm_private_ip" {
  description = "Private IP of the backend VM"
  type        = string
}

variable "appgw_name" {
  description = "The name of the Application Gateway"
  type        = string
  default     = "arc-test-gateway"
}

variable "appgw_public_ip_name" {
  description = "The name of the Public IP for the Application Gateway"
  type        = string
  default     = "arc-test-gateway-ip"
}

