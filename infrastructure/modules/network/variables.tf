variable "resource_group_name" {
  description = "Name of the Resource Group that contains the network resources."
  type        = string

  validation {
    condition     = length(trimspace(var.resource_group_name)) > 0
    error_message = "resource_group_name must not be empty."
  }
}

variable "location" {
  description = "Azure region for the network resources."
  type        = string

  validation {
    condition     = length(trimspace(var.location)) > 0
    error_message = "location must not be empty."
  }
}

variable "virtual_network_name" {
  description = "Name of the Azure Virtual Network."
  type        = string

  validation {
    condition     = length(trimspace(var.virtual_network_name)) > 0
    error_message = "virtual_network_name must not be empty."
  }
}

variable "address_space" {
  description = "CIDR address spaces assigned to the Virtual Network."
  type        = list(string)

  validation {
    condition = (
      length(var.address_space) > 0 &&
      alltrue([
        for cidr in var.address_space : can(cidrhost(cidr, 0))
      ])
    )

    error_message = "address_space must contain at least one valid CIDR block."
  }
}

variable "subnets" {
  description = "Subnet, delegation, NSG, and optional security-rule definitions keyed by logical subnet name."

  type = map(object({
    name                              = string
    address_prefixes                  = list(string)
    service_endpoints                 = optional(set(string), [])
    private_endpoint_network_policies = optional(string, "Disabled")
    network_security_group_name       = optional(string)

    delegation = optional(object({
      name         = string
      service_name = string
      actions      = optional(set(string), [])
    }))

    security_rules = optional(map(object({
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = optional(string, "*")
      destination_port_range     = optional(string, "*")
      source_address_prefix      = optional(string, "*")
      destination_address_prefix = optional(string, "*")
      description                = optional(string)
    })), {})
  }))

  validation {
    condition = (
      length(var.subnets) > 0 &&
      alltrue([
        for subnet in values(var.subnets) : (
          length(trimspace(subnet.name)) > 0 &&
          length(subnet.address_prefixes) > 0 &&
          alltrue([
            for cidr in subnet.address_prefixes : can(cidrhost(cidr, 0))
          ])
        )
      ])
    )

    error_message = "Every subnet must have a name and at least one valid CIDR block."
  }

  validation {
    condition = alltrue([
      for subnet in values(var.subnets) : contains(
        [
          "Disabled",
          "Enabled",
          "NetworkSecurityGroupEnabled",
          "RouteTableEnabled"
        ],
        subnet.private_endpoint_network_policies
      )
    ])

    error_message = "private_endpoint_network_policies contains an unsupported value."
  }

  validation {
    condition = alltrue(flatten([
      for subnet in values(var.subnets) : [
        for rule in values(subnet.security_rules) : (
          rule.priority >= 100 &&
          rule.priority <= 4096 &&
          contains(["Inbound", "Outbound"], rule.direction) &&
          contains(["Allow", "Deny"], rule.access) &&
          contains(["Tcp", "Udp", "Icmp", "Esp", "Ah", "*"], rule.protocol)
        )
      ]
    ]))

    error_message = "Every security rule must use a valid priority, direction, access value, and protocol."
  }

  validation {
    condition = alltrue([
      for subnet in values(var.subnets) : (
        subnet.network_security_group_name != null ||
        length(subnet.security_rules) == 0
      )
    ])

    error_message = "A subnet with security_rules must define network_security_group_name."
  }
}

variable "tags" {
  description = "Tags applied to taggable network resources."
  type        = map(string)
  default     = {}
}
