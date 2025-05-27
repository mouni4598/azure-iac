output "identity_id" {
  description = "The ID of the User Assigned Managed Identity"
  value       = azurerm_user_assigned_identity.this.id
}
output "principal_id" {
  value = azurerm_user_assigned_identity.this.principal_id
}

