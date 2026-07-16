variable "subscription_id" {
  description = "Azure subscription ID in which the Terraform state resources are created."
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

variable "state_admin_principal_id" {
  description = "Microsoft Entra object ID granted access to the Terraform state storage account."
  type        = string
  sensitive   = true

  validation {
    condition = can(
      regex(
        "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$",
        var.state_admin_principal_id
      )
    )

    error_message = "state_admin_principal_id must be a valid UUID."
  }
}

variable "location" {
  description = "Azure region for the Terraform state resources."
  type        = string
  default     = "westeurope"

  validation {
    condition     = length(trimspace(var.location)) > 0
    error_message = "location must not be empty."
  }
}

variable "storage_account_name_override" {
  description = "Optional globally unique Storage Account name."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition = (
      var.storage_account_name_override == null
      || can(
        regex(
          "^[a-z0-9]{3,24}$",
          var.storage_account_name_override
        )
      )
    )

    error_message = "storage_account_name_override must contain 3-24 lowercase letters and numbers."
  }
}

variable "container_name" {
  description = "Blob Container name for Terraform state files."
  type        = string
  default     = "tfstate"

  validation {
    condition = can(
      regex(
        "^[a-z0-9](?:[a-z0-9-]{1,61}[a-z0-9])?$",
        var.container_name
      )
    )

    error_message = "container_name must be a valid Azure Blob Container name."
  }
}

variable "soft_delete_retention_days" {
  description = "Number of days deleted blobs and containers are retained."
  type        = number
  default     = 7

  validation {
    condition = (
      var.soft_delete_retention_days >= 1
      && var.soft_delete_retention_days <= 365
    )

    error_message = "soft_delete_retention_days must be between 1 and 365."
  }
}

variable "additional_tags" {
  description = "Additional tags merged with mandatory Terraform state tags."
  type        = map(string)
  default     = {}
}

variable "storage_account_location" {
  description = "Azure region for the Terraform state Storage Account."
  type        = string
  default     = "polandcentral"

  validation {
    condition     = length(trimspace(var.storage_account_location)) > 0
    error_message = "storage_account_location must not be empty."
  }
}
