output "id" {
  description = "Resource ID of the Azure Container Registry."
  value       = azurerm_container_registry.this.id
}

output "name" {
  description = "Name of the Azure Container Registry."
  value       = azurerm_container_registry.this.name
}

output "login_server" {
  description = "Hostname used to authenticate, push, and pull container images."
  value       = azurerm_container_registry.this.login_server
}

output "resource_group_name" {
  description = "Name of the Resource Group containing the Azure Container Registry."
  value       = azurerm_container_registry.this.resource_group_name
}

output "sku" {
  description = "Service tier of the Azure Container Registry."
  value       = azurerm_container_registry.this.sku
}