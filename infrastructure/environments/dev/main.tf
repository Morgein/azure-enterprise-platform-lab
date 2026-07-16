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
