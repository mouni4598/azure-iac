output "sql_server_name" {
  value = azurerm_mssql_server.this.name
}

output "sql_server_fqdn" {
  value = azurerm_mssql_server.this.fully_qualified_domain_name
}

output "sql_database_names" {
  value = [
    azurerm_mssql_database.arc_sqlserver.name,
    azurerm_mssql_database.arc_saga.name
  ]
}


