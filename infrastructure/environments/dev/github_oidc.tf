module "github_oidc" {
  source = "../../modules/github_oidc"

  identity_name             = "id-github-actions-deploy-${var.environment}"
  federated_credential_name = "fic-github-actions-${var.environment}"
  resource_group_name       = azurerm_resource_group.platform.name
  location                  = azurerm_resource_group.platform.location
  github_repository         = "Morgein@104425675/azure-enterprise-platform-lab@1302301100"
  github_environment        = "development"
  container_registry_id     = module.container_registry.id
  container_app_id          = module.container_apps.container_app_id

  tags = merge(
    local.common_tags,
    {
      Component = "ContinuousDelivery"
    }
  )
}