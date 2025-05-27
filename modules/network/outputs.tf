output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "vm_subnet_id" {
  value = azurerm_subnet.vm_subnet.id
}

output "appgw_subnet_id" {
  value = azurerm_subnet.appgw_subnet.id
}
output "private_dns_zone_id" {
  value = azurerm_private_dns_zone.sql.id
}
