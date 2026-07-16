locals {
  name_prefix = lower(
    join(
      "-",
      [
        "aeplab",
        var.workload_name,
        var.environment
      ]
    )
  )

  compact_name_prefix = replace(
    local.name_prefix,
    "-",
    ""
  )

  resource_group_name  = "rg-${local.name_prefix}"
  virtual_network_name = "vnet-${local.name_prefix}"

  mandatory_tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "Azure Enterprise Platform Lab"
    Repository  = "azure-enterprise-platform-lab"
    Workload    = var.workload_name
    CostProfile = "StudentLab"
  }

  common_tags = merge(
    local.mandatory_tags,
    var.additional_tags
  )

  network_subnets = {
    container_apps = {
      name                        = "snet-container-apps-${var.environment}"
      address_prefixes            = var.subnet_address_prefixes.container_apps
      network_security_group_name = "nsg-container-apps-${var.environment}"

      delegation = {
        name         = "container-apps-environment"
        service_name = "Microsoft.App/environments"

        actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action"
        ]
      }
    }

    api_management = {
      name                        = "snet-api-management-${var.environment}"
      address_prefixes            = var.subnet_address_prefixes.api_management
      network_security_group_name = "nsg-api-management-${var.environment}"
    }

    application = {
      name                        = "snet-application-${var.environment}"
      address_prefixes            = var.subnet_address_prefixes.application
      network_security_group_name = "nsg-application-${var.environment}"
    }

    data = {
      name                        = "snet-data-${var.environment}"
      address_prefixes            = var.subnet_address_prefixes.data
      network_security_group_name = "nsg-data-${var.environment}"
    }

    private_endpoints = {
      name                              = "snet-private-endpoints-${var.environment}"
      address_prefixes                  = var.subnet_address_prefixes.private_endpoints
      private_endpoint_network_policies = "Enabled"
      network_security_group_name       = "nsg-private-endpoints-${var.environment}"
    }

    management = {
      name                        = "snet-management-${var.environment}"
      address_prefixes            = var.subnet_address_prefixes.management
      network_security_group_name = "nsg-management-${var.environment}"
    }
  }
}
