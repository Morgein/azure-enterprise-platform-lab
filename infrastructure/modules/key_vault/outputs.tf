output "id" {
  description = "Resource ID of the Azure Key Vault."
  value       = azurerm_key_vault.this.id
}

output "name" {
  description = "Name of the Azure Key Vault."
  value       = azurerm_key_vault.this.name
}

output "vault_uri" {
  description = "Data-plane URI used by applications to access the Azure Key Vault."
  value       = azurerm_key_vault.this.vault_uri
}

output "resource_group_name" {
  description = "Name of the Resource Group containing the Azure Key Vault."
  value       = azurerm_key_vault.this.resource_group_name
}

output "location" {
  description = "Azure region containing the Azure Key Vault."
  value       = azurerm_key_vault.this.location
}

output "sku_name" {
  description = "Service tier of the Azure Key Vault."
  value       = azurerm_key_vault.this.sku_name
}

output "rbac_authorization_enabled" {
  description = "Indicates whether Azure RBAC authorization is enabled."
  value       = azurerm_key_vault.this.rbac_authorization_enabled
}

output "public_network_access_enabled" {
  description = "Indicates whether the Key Vault public endpoint is enabled."
  value       = azurerm_key_vault.this.public_network_access_enabled
}

output "purge_protection_enabled" {
  description = "Indicates whether purge protection is enabled."
  value       = azurerm_key_vault.this.purge_protection_enabled
}

output "soft_delete_retention_days" {
  description = "Number of days that deleted Key Vault objects remain recoverable."
  value       = azurerm_key_vault.this.soft_delete_retention_days
}

output "application_secrets_user_role_assignment_id" {
  description = "Resource ID of the application Key Vault Secrets User role assignment."
  value = try(
    azurerm_role_assignment.application_secrets_user[0].id,
    null
  )
}

output "key_vault" {
  description = "Non-sensitive Azure Key Vault deployment information."

  value = {
    id                              = azurerm_key_vault.this.id
    name                            = azurerm_key_vault.this.name
    vault_uri                       = azurerm_key_vault.this.vault_uri
    resource_group_name             = azurerm_key_vault.this.resource_group_name
    location                        = azurerm_key_vault.this.location
    sku_name                        = azurerm_key_vault.this.sku_name
    rbac_authorization_enabled      = azurerm_key_vault.this.rbac_authorization_enabled
    public_network_access_enabled   = azurerm_key_vault.this.public_network_access_enabled
    purge_protection_enabled        = azurerm_key_vault.this.purge_protection_enabled
    soft_delete_retention_days      = azurerm_key_vault.this.soft_delete_retention_days
    application_secret_access_grant = var.grant_application_secret_access
  }
}