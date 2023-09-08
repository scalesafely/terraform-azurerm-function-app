output "function_app_identity_principal_id" {
  value = azurerm_linux_function_app.functionapp_lf.identity[0].principal_id
}
