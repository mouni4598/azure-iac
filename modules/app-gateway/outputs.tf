output "appgw_id" {
  description = "The ID of the Application Gateway"
  value       = azurerm_application_gateway.this.id
}

output "appgw_public_ip" {
  description = "The public IP address of the Application Gateway"
  value       = azurerm_public_ip.appgw_pip.ip_address
}

output "backend_address_pool_id" {
  description = "The backend address pool ID"
  value = [
    for pool in azurerm_application_gateway.this.backend_address_pool :
    pool.id if pool.name == "appgw-backendpool"
  ][0]
}
