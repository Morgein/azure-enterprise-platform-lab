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
  default     = "westeurope"

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

variable "additional_tags" {
  description = "Additional tags merged with mandatory platform tags."
  type        = map(string)
  default     = {}
}
