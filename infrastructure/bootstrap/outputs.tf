output "resource_group_name" {
  description = "Resource Group containing Terraform state resources."
  value       = azurerm_resource_group.state.name
}

output "storage_account_name" {
  description = "Storage Account used for Terraform remote state."
  value       = azurerm_storage_account.state.name
}

output "container_name" {
  description = "Blob Container used for Terraform remote state."
  value       = azurerm_storage_container.state.name
}

output "storage_account_id" {
  description = "Resource ID of the Terraform state Storage Account."
  value       = azurerm_storage_account.state.id
}

output "backend_configuration" {
  description = "Non-secret AzureRM backend configuration."

  value = {
    resource_group_name  = azurerm_resource_group.state.name
    storage_account_name = azurerm_storage_account.state.name
    container_name       = azurerm_storage_container.state.name
    key                  = "dev/terraform.tfstate"
    use_azuread_auth     = true
  }
}
