output "Namespace_Connection_String" {
  value = "${azurerm_servicebus_namespace.example.default_primary_connection_string}"
}

output "Shared_Access_Policy_PrimaryKey" {
  value = "${azurerm_servicebus_namespace.example.default_primary_key}"
}
