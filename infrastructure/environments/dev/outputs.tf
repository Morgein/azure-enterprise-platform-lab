output "deployment_context" {
  description = "Non-sensitive deployment context for the development environment."

  value = {
    environment         = var.environment
    location            = var.location
    name_prefix         = local.name_prefix
    compact_name_prefix = local.compact_name_prefix
    common_tags         = local.common_tags
  }
}

output "resource_group" {
  description = "Development Resource Group details."

  value = {
    id       = azurerm_resource_group.platform.id
    name     = azurerm_resource_group.platform.name
    location = azurerm_resource_group.platform.location
  }
}

output "network" {
  description = "Development Virtual Network, subnet, and NSG details."

  value = {
    virtual_network_id            = module.network.virtual_network_id
    virtual_network_name          = module.network.virtual_network_name
    virtual_network_address_space = module.network.virtual_network_address_space
    subnets                       = module.network.subnet_details
    network_security_group_ids    = module.network.network_security_group_ids
  }
}

output "container_registry" {
  description = "Non-sensitive configuration of the development Azure Container Registry."

  value = {
    id           = module.container_registry.id
    name         = module.container_registry.name
    login_server = module.container_registry.login_server
    sku          = module.container_registry.sku
  }
}

output "container_apps" {
  description = "Non-sensitive configuration of the development Azure Container Apps deployment."

  value = {
    environment_name     = module.container_apps.environment_name
    environment_domain   = module.container_apps.environment_default_domain
    container_app_name   = module.container_apps.container_app_name
    container_app_fqdn   = module.container_apps.container_app_fqdn
    latest_revision_name = module.container_apps.latest_revision_name
  }
}