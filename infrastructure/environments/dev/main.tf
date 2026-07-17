resource "azurerm_resource_group" "platform" {
  name     = local.resource_group_name
  location = var.location
  tags     = local.common_tags
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

  external_ingress_enabled = true

  tags = local.common_tags
}