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