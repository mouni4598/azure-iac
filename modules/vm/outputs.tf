output "vm_public_ip" {
  value = azurerm_public_ip.vm_public_ip.ip_address
}
output "vm_id" {
  value = azurerm_linux_virtual_machine.vm.id
}
output "private_ip_address" {
  value = azurerm_network_interface.vm_nic.private_ip_address
}
output "nic_id" {
  value = azurerm_network_interface.vm_nic.id
}
