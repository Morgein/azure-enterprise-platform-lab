output "environment_id" {
  description = "Resource ID of the Container Apps Managed Environment."
  value       = azurerm_container_app_environment.this.id
}

output "environment_name" {
  description = "Name of the Container Apps Managed Environment."
  value       = azurerm_container_app_environment.this.name
}

output "environment_default_domain" {
  description = "Default domain of the Container Apps Managed Environment."
  value       = azurerm_container_app_environment.this.default_domain
}

output "container_app_id" {
  description = "Resource ID of the Azure Container App."
  value       = azurerm_container_app.this.id
}

output "container_app_name" {
  description = "Name of the Azure Container App."
  value       = azurerm_container_app.this.name
}

output "container_app_fqdn" {
  description = "Stable public fully qualified domain name of the Azure Container App."
  value       = azurerm_container_app.this.ingress[0].fqdn
}

output "latest_revision_name" {
  description = "Name of the latest deployed Container App revision."
  value       = azurerm_container_app.this.latest_revision_name
}

output "managed_identity_id" {
  description = "Resource ID of the User Assigned Managed Identity."
  value       = azurerm_user_assigned_identity.this.id
}

output "managed_identity_client_id" {
  description = "Client ID of the User Assigned Managed Identity."
  value       = azurerm_user_assigned_identity.this.client_id
}

output "managed_identity_principal_id" {
  description = "Principal ID of the User Assigned Managed Identity."
  value       = azurerm_user_assigned_identity.this.principal_id
}