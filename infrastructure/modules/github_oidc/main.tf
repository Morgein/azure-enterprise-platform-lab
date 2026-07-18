locals {
  github_oidc_issuer = "https://token.actions.githubusercontent.com"

  federated_subject = join(":", [
    "repo",
    var.github_repository,
    "environment",
    var.github_environment,
  ])
}

data "azurerm_client_config" "current" {}

resource "azurerm_user_assigned_identity" "this" {
  name                = var.identity_name
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = var.tags
}

resource "azurerm_federated_identity_credential" "github_environment" {
  name                      = var.federated_credential_name
  user_assigned_identity_id = azurerm_user_assigned_identity.this.id
  audience = [
    "api://AzureADTokenExchange",
  ]

  issuer  = local.github_oidc_issuer
  subject = local.federated_subject
}

resource "azurerm_role_assignment" "registry_push" {
  scope                = var.container_registry_id
  role_definition_name = "AcrPush"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
  principal_type       = "ServicePrincipal"

  description = "Allows the GitHub Actions deployment identity to push application images to ACR."

  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "container_app_deployment" {
  scope                = var.container_app_id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
  principal_type       = "ServicePrincipal"

  description = "Allows the GitHub Actions deployment identity to update the development Container App."

  skip_service_principal_aad_check = true
}