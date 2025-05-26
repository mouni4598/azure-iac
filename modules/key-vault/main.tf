resource "azurerm_key_vault" "this" {
  name                        = "test-keyvault"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = var.managed_identity_principal_id

    secret_permissions = [
      "get", "list", "set", "delete"
    ]
    certificate_permissions = []
    key_permissions = []
    storage_permissions = []
  }
}

data "azurerm_client_config" "current" {}
