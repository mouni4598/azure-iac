resource "azurerm_mssql_server" "this" {
  name                         = "arc-onprem-sqlserver"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password

  identity {
    type = "SystemAssigned"
  }

  public_network_access_enabled = true
}

resource "azurerm_mssql_database" "arc_sqlserver" {
  name           = "arc-sqlserver-test"
  server_id      = azurerm_mssql_server.this.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  sku_name       = "GP_Gen5_2"
  max_size_gb    = 32
}

resource "azurerm_mssql_database" "arc_saga" {
  name                        = "arc-saga-test"
  server_id                   = azurerm_mssql_server.this.id
  collation                   = "SQL_Latin1_General_CP1_CI_AS"
  sku_name                    = "GP_S_Gen5_1"
  max_size_gb                 = 32

  # Serverless settings required
  min_capacity                = 0.5
  auto_pause_delay_in_minutes = 60  # Auto-pauses after 60 mins idle
}



resource "azurerm_private_endpoint" "sql_private_endpoint" {
  name                = "arc-onprem-sqlserver-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "arc-onprem-sqlserver-conn"
    private_connection_resource_id = azurerm_mssql_server.this.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }
}


resource "azurerm_mssql_firewall_rule" "vm_allow" {
  name             = "VM-IP-Allow"
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = "172.190.208.215"
  end_ip_address   = "172.190.208.215"
}

# resource "azurerm_mssql_firewall_rule" "client_allow" {
#   for_each = {
#     rule1 = { start = "49.205.105.141", end = "49.205.105.141" }
#     rule2 = { start = "72.177.67.215", end = "72.177.67.215" }
#     rule3 = { start = "49.205.105.47", end = "49.205.105.47" }
#   }

#   name             = each.key
#   server_id        = azurerm_mssql_server.this.id
#   start_ip_address = each.value.start
#   end_ip_address   = each.value.end
# }
