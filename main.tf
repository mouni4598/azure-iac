data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}
module "network" {
  source              = "./modules/network"
  vnet_name           = var.vnet_name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name


  address_space       = var.address_space
  vm_subnet_name      = var.vm_subnet_name
  vm_subnet_prefix    = var.vm_subnet_prefix
  appgw_subnet_name   = var.appgw_subnet_name
  appgw_subnet_prefix = var.appgw_subnet_prefix
}
module "vm" {
  source              = "./modules/vm"
  vm_name             = var.vm_name
  vm_size             = var.vm_size
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.network.vm_subnet_id
  admin_username      = var.admin_username
  admin_password      = var.admin_password
}
module "managed_identity" {
  source              = "./modules/managed-identity"
  identity_name       = "arc-onprem-mi"
  location            = var.location
  resource_group_name = var.resource_group_name
}
module "key_vault" {
  source                        = "./modules/key-vault"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  managed_identity_principal_id = module.managed_identity.principal_id
  tenant_id                     = data.azurerm_client_config.current.tenant_id
}
