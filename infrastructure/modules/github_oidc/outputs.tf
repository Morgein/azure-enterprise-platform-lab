output "identity_id" {
  description = "Resource ID of the GitHub Actions deployment identity."
  value       = azurerm_user_assigned_identity.this.id
  sensitive   = true
}

output "identity_name" {
  description = "Name of the GitHub Actions deployment identity."
  value       = azurerm_user_assigned_identity.this.name
}

output "client_id" {
  description = "Client ID used by GitHub Actions for Azure OIDC authentication."
  value       = azurerm_user_assigned_identity.this.client_id
  sensitive   = true
}

output "principal_id" {
  description = "Principal ID of the GitHub Actions deployment identity."
  value       = azurerm_user_assigned_identity.this.principal_id
  sensitive   = true
}

output "tenant_id" {
  description = "Microsoft Entra tenant ID used by the Azure Login action."
  value       = data.azurerm_client_config.current.tenant_id
  sensitive   = true
}

output "subscription_id" {
  description = "Azure subscription ID used by the Azure Login action."
  value       = data.azurerm_client_config.current.subscription_id
  sensitive   = true
}

output "federated_subject" {
  description = "OIDC subject trusted by the Azure Federated Identity Credential."
  value       = local.federated_subject
}

output "github_environment" {
  description = "GitHub Environment trusted for Azure deployments."
  value       = var.github_environment
}