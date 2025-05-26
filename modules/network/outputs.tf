output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "vm_subnet_id" {
  value = azurerm_subnet.vm_subnet.id
}

output "appgw_subnet_id" {
  value = azurerm_subnet.appgw_subnet.id
}
