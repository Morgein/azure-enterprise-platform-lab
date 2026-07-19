resource "azurerm_resource_group" "platform" {
  name     = local.resource_group_name
  location = var.location
  tags     = local.common_tags
}

module "governance" {
  source = "../../modules/governance"

  name            = "budget-${local.name_prefix}-monthly"
  subscription_id = var.subscription_id

  amount     = var.monthly_budget_amount
  start_date = var.budget_start_date
  end_date   = var.budget_end_date

  contact_emails = var.budget_contact_emails
}

module "network" {
  source = "../../modules/network"

  resource_group_name  = azurerm_resource_group.platform.name
  location             = azurerm_resource_group.platform.location
  virtual_network_name = local.virtual_network_name
  address_space        = var.virtual_network_address_space
  subnets              = local.network_subnets
  tags                 = local.common_tags
}

module "container_registry" {
  source = "../../modules/container_registry"

  name                          = var.container_registry_name
  resource_group_name           = azurerm_resource_group.platform.name
  location                      = azurerm_resource_group.platform.location
  sku                           = var.container_registry_sku
  public_network_access_enabled = true

  tags = local.common_tags
}

module "container_apps" {
  source = "../../modules/container_apps"

  environment_name   = "cae-${local.name_prefix}"
  container_app_name = "ca-azure-platform-api-${var.environment}"
  container_name     = "azure-platform-api"
  identity_name      = "id-azure-platform-api-${var.environment}"

  resource_group_name = azurerm_resource_group.platform.name
  location            = azurerm_resource_group.platform.location

  infrastructure_subnet_id = module.network.subnet_ids["container_apps"]

  container_registry_id             = module.container_registry.id
  container_registry_login_server   = module.container_registry.login_server
  container_registry_pull_role_name = "AcrPull"

  container_image = var.container_image
  target_port     = 8000

  container_resources = {
    cpu    = 0.25
    memory = "0.5Gi"
  }

  scale = {
    min_replicas = 0
    max_replicas = 1
  }

  environment_variables = {
    APP_ENV = var.environment
  }

  external_ingress_enabled = true

  tags = local.common_tags
}

module "key_vault" {
  source = "../../modules/key_vault"

  name                = var.key_vault_name
  location            = azurerm_resource_group.platform.location
  resource_group_name = azurerm_resource_group.platform.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = true

  public_network_access_enabled = true
  network_default_action        = "Allow"
  network_bypass                = "AzureServices"

  allowed_ip_rules   = []
  allowed_subnet_ids = []

  application_identity_principal_id = module.container_apps.managed_identity_principal_id
  grant_application_secret_access   = true

  tags = merge(
    local.common_tags,
    {
      Component = "SecretsManagement"
      Phase     = "IdentityFoundation"
    }
  )
}