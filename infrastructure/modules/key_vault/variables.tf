variable "name" {
  description = "Globally unique name of the Azure Key Vault."
  type        = string

  validation {
    condition = (
      length(var.name) >= 3 &&
      length(var.name) <= 24 &&
      can(regex("^[a-z][a-z0-9-]*[a-z0-9]$", var.name)) &&
      !strcontains(var.name, "--")
    )
    error_message = "The Key Vault name must contain 3-24 lowercase letters, numbers, or hyphens, begin with a letter, end with a letter or number, and must not contain consecutive hyphens."
  }
}

variable "location" {
  description = "Azure region where the Key Vault will be deployed."
  type        = string

  validation {
    condition     = length(trimspace(var.location)) > 0
    error_message = "The Azure location must not be empty."
  }
}

variable "resource_group_name" {
  description = "Name of the Resource Group that contains the Key Vault."
  type        = string

  validation {
    condition     = length(trimspace(var.resource_group_name)) > 0
    error_message = "The Resource Group name must not be empty."
  }
}

variable "tenant_id" {
  description = "Microsoft Entra tenant ID used by the Key Vault."
  type        = string
  sensitive   = true

  validation {
    condition = can(
      regex(
        "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$",
        var.tenant_id
      )
    )
    error_message = "The tenant ID must be a valid UUID."
  }
}

variable "sku_name" {
  description = "Azure Key Vault service tier."
  type        = string
  default     = "standard"

  validation {
    condition     = contains(["standard", "premium"], lower(var.sku_name))
    error_message = "The Key Vault SKU must be either standard or premium."
  }
}

variable "soft_delete_retention_days" {
  description = "Number of days that deleted Key Vault objects remain recoverable."
  type        = number
  default     = 7

  validation {
    condition = (
      var.soft_delete_retention_days >= 7 &&
      var.soft_delete_retention_days <= 90
    )
    error_message = "Soft-delete retention must be between 7 and 90 days."
  }
}

variable "purge_protection_enabled" {
  description = "Controls whether purge protection is enabled for the Key Vault."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Controls whether the Key Vault public endpoint is enabled."
  type        = bool
  default     = true
}

variable "network_default_action" {
  description = "Default Key Vault network action when no network rule matches."
  type        = string
  default     = "Allow"

  validation {
    condition     = contains(["Allow", "Deny"], var.network_default_action)
    error_message = "The network default action must be either Allow or Deny."
  }
}

variable "network_bypass" {
  description = "Specifies whether trusted Azure services can bypass network rules."
  type        = string
  default     = "AzureServices"

  validation {
    condition     = contains(["AzureServices", "None"], var.network_bypass)
    error_message = "The network bypass value must be AzureServices or None."
  }
}

variable "allowed_ip_rules" {
  description = "Public IPv4 addresses or CIDR ranges allowed by the Key Vault firewall."
  type        = list(string)
  default     = []
}

variable "allowed_subnet_ids" {
  description = "Azure subnet IDs allowed to access the Key Vault public endpoint."
  type        = list(string)
  default     = []
}

variable "application_identity_principal_id" {
  description = "Principal ID of the application Managed Identity that receives secret read access."
  type        = string

  validation {
    condition = can(
      regex(
        "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$",
        var.application_identity_principal_id
      )
    )
    error_message = "The application identity principal ID must be a valid UUID."
  }
}

variable "grant_application_secret_access" {
  description = "Controls creation of the Key Vault Secrets User role assignment."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to the Azure Key Vault."
  type        = map(string)
  default     = {}
}