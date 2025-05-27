resource "azurerm_key_vault" "this" {
  name                        = "onpremarc-keyvault"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"

    access_policy {
      tenant_id = data.azurerm_client_config.current.tenant_id
      object_id = var.managed_identity_principal_id

      secret_permissions = [
    "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"
  ]

  certificate_permissions = [
    "Get", "List", "Create", "Import", "Update", "Delete", "Recover", "Backup", "Restore", "Purge"
  ]

  key_permissions = [
    "Get", "List", "Create", "Update", "Delete", "Recover", "Backup", "Restore", "Purge", "Encrypt", "Decrypt", "Sign", "Verify", "WrapKey", "UnwrapKey", "Import", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"
  ]

  storage_permissions = [
    "Get", "List", "Delete", "Set", "Update", "RegenerateKey", "Recover", "Backup", "Restore", "Purge"
  ]
    }
  }

  data "azurerm_client_config" "current" {}
