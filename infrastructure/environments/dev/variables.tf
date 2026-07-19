variable "subscription_id" {
  description = "Azure subscription ID used for the development environment."
  type        = string
  sensitive   = true

  validation {
    condition = can(
      regex(
        "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$",
        var.subscription_id
      )
    )

    error_message = "subscription_id must be a valid UUID."
  }
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
  default     = "dev"

  validation {
    condition = contains(
      ["dev", "staging", "production"],
      var.environment
    )

    error_message = "environment must be dev, staging, or production."
  }
}

variable "location" {
  description = "Primary Azure region for the environment."
  type        = string
  default     = "polandcentral"

  validation {
    condition     = length(trimspace(var.location)) > 0
    error_message = "location must not be empty."
  }
}

variable "workload_name" {
  description = "Short workload name used in Azure resource naming."
  type        = string
  default     = "platform"

  validation {
    condition = can(
      regex(
        "^[a-z][a-z0-9-]{1,18}[a-z0-9]$",
        var.workload_name
      )
    )

    error_message = "workload_name must contain 3-20 lowercase letters, numbers, or hyphens."
  }
}

variable "monthly_budget_amount" {
  description = "Maximum expected monthly spending amount for the development Azure Subscription Budget."
  type        = number
  default     = 10

  validation {
    condition     = var.monthly_budget_amount > 0
    error_message = "monthly_budget_amount must be greater than zero."
  }
}

variable "budget_start_date" {
  description = "Start date of the Azure Subscription Budget in RFC3339 format."
  type        = string

  validation {
    condition = can(
      regex(
        "^[0-9]{4}-[0-9]{2}-01T00:00:00Z$",
        var.budget_start_date,
      )
    )

    error_message = "budget_start_date must use RFC3339 format and the first day of a month."
  }
}

variable "budget_end_date" {
  description = "End date of the Azure Subscription Budget in RFC3339 format."
  type        = string

  validation {
    condition = can(
      regex(
        "^[0-9]{4}-[0-9]{2}-01T00:00:00Z$",
        var.budget_end_date,
      )
    )

    error_message = "budget_end_date must use RFC3339 format and the first day of a month."
  }
}

variable "budget_contact_emails" {
  description = "Email addresses that receive Azure Cost Management budget notifications."
  type        = list(string)
  sensitive   = true

  validation {
    condition = (
      length(var.budget_contact_emails) > 0 &&
      alltrue([
        for email in var.budget_contact_emails :
        can(regex("^[^@[:space:]]+@[^@[:space:]]+\\.[^@[:space:]]+$", email))
      ])
    )

    error_message = "budget_contact_emails must contain at least one valid email address."
  }
}

variable "virtual_network_address_space" {
  description = "CIDR address spaces assigned to the development Virtual Network."
  type        = list(string)
  default     = ["10.20.0.0/16"]

  validation {
    condition = (
      length(var.virtual_network_address_space) > 0 &&
      alltrue([
        for cidr in var.virtual_network_address_space :
        can(cidrhost(cidr, 0))
      ])
    )

    error_message = "virtual_network_address_space must contain at least one valid CIDR block."
  }
}

variable "subnet_address_prefixes" {
  description = "CIDR address prefixes assigned to the development subnets."

  type = object({
    container_apps    = list(string)
    api_management    = list(string)
    application       = list(string)
    data              = list(string)
    private_endpoints = list(string)
    management        = list(string)
  })

  default = {
    container_apps    = ["10.20.0.0/23"]
    api_management    = ["10.20.2.0/24"]
    application       = ["10.20.3.0/24"]
    data              = ["10.20.4.0/24"]
    private_endpoints = ["10.20.5.0/24"]
    management        = ["10.20.6.0/24"]
  }

  validation {
    condition = alltrue([
      for prefixes in [
        var.subnet_address_prefixes.container_apps,
        var.subnet_address_prefixes.api_management,
        var.subnet_address_prefixes.application,
        var.subnet_address_prefixes.data,
        var.subnet_address_prefixes.private_endpoints,
        var.subnet_address_prefixes.management
        ] : (
        length(prefixes) > 0 &&
        alltrue([
          for cidr in prefixes :
          can(cidrhost(cidr, 0))
        ])
      )
    ])

    error_message = "Every subnet must contain at least one valid CIDR block."
  }
}

variable "additional_tags" {
  description = "Additional tags merged with mandatory platform tags."
  type        = map(string)
  default     = {}
}

variable "container_registry_name" {
  description = "Globally unique name of the development Azure Container Registry."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{5,50}$", var.container_registry_name))
    error_message = "The Container Registry name must contain only lowercase letters and numbers and must be between 5 and 50 characters long."
  }
}

variable "container_registry_sku" {
  description = "Service tier of the development Azure Container Registry."
  type        = string
  default     = "Basic"

  validation {
    condition = contains(
      [
        "Basic",
        "Standard",
        "Premium",
      ],
      var.container_registry_sku,
    )

    error_message = "The Container Registry SKU must be Basic, Standard, or Premium."
  }
}

variable "container_image" {
  description = "Immutable Azure Container Registry image deployed to the development Container App."
  type        = string

  validation {
    condition = can(regex(
      "^[a-z0-9]+\\.azurecr\\.io/[a-z0-9._/-]+@sha256:[a-f0-9]{64}$",
      var.container_image,
    ))

    error_message = "The container image must be an immutable ACR reference ending with @sha256:<64 hexadecimal characters>."
  }
}

variable "key_vault_name" {
  description = "Globally unique name of the development Azure Key Vault."
  type        = string

  validation {
    condition = (
      length(var.key_vault_name) >= 3 &&
      length(var.key_vault_name) <= 24 &&
      can(regex("^[a-z][a-z0-9-]*[a-z0-9]$", var.key_vault_name)) &&
      !strcontains(var.key_vault_name, "--")
    )
    error_message = "The Key Vault name must contain 3-24 lowercase letters, numbers, or hyphens, begin with a letter, end with a letter or number, and must not contain consecutive hyphens."
  }
}