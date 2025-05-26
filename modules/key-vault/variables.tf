variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "managed_identity_principal_id" {
  type = string
  description = "The principal ID of the managed identity"
}
variable "tenant_id" {
  description = "The tenant ID for the Key Vault"
  type        = string
}
