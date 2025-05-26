output "vnet_id" {
  description = "ID of the created virtual network"
  value       = module.network.vnet_id
}

output "vm_subnet_id" {
  description = "ID of the VM subnet"
  value       = module.network.vm_subnet_id
}

output "appgw_subnet_id" {
  description = "ID of the Application Gateway subnet"
  value       = module.network.appgw_subnet_id
}

