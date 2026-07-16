locals {
  nsg_subnets = {
    for subnet_key, subnet in var.subnets :
    subnet_key => subnet
    if subnet.network_security_group_name != null
  }

  security_rules = merge(
    {},
    [
      for subnet_key, subnet in var.subnets : {
        for rule_name, rule in subnet.security_rules :
        "${subnet_key}.${rule_name}" => merge(
          rule,
          {
            name       = rule_name
            subnet_key = subnet_key
          }
        )
      }
      if subnet.network_security_group_name != null
    ]...
  )
}

resource "azurerm_virtual_network" "this" {
  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  tags                = var.tags
}

resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                              = each.value.name
  resource_group_name               = var.resource_group_name
  virtual_network_name              = azurerm_virtual_network.this.name
  address_prefixes                  = each.value.address_prefixes
  service_endpoints                 = sort(tolist(each.value.service_endpoints))
  private_endpoint_network_policies = each.value.private_endpoint_network_policies

  dynamic "delegation" {
    for_each = each.value.delegation == null ? [] : [each.value.delegation]

    content {
      name = delegation.value.name

      service_delegation {
        name = delegation.value.service_name
        actions = (
          length(delegation.value.actions) > 0
          ? sort(tolist(delegation.value.actions))
          : null
        )
      }
    }
  }
}

resource "azurerm_network_security_group" "this" {
  for_each = local.nsg_subnets

  name                = each.value.network_security_group_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "this" {
  for_each = local.security_rules

  name                        = each.value.name
  description                 = each.value.description
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this[each.value.subnet_key].name
}

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = local.nsg_subnets

  subnet_id                 = azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.this[each.key].id
}
