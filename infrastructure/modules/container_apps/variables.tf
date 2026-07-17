variable "environment_name" {
  description = "Name of the Azure Container Apps Managed Environment."
  type        = string

  validation {
    condition     = length(trimspace(var.environment_name)) > 0
    error_message = "The Container Apps Managed Environment name must not be empty."
  }
}

variable "container_app_name" {
  description = "Name of the Azure Container App."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,30}[a-z0-9]$", var.container_app_name))
    error_message = "The Container App name must contain lowercase letters, numbers, or hyphens, start with a letter, end with a letter or number, and contain between 3 and 32 characters."
  }
}

variable "container_name" {
  description = "Name of the application container inside the Container App."
  type        = string
  default     = "azure-platform-api"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,30}[a-z0-9]$", var.container_name))
    error_message = "The container name must contain lowercase letters, numbers, or hyphens, start with a letter, and end with a letter or number."
  }
}

variable "identity_name" {
  description = "Name of the User Assigned Managed Identity used by the Container App."
  type        = string

  validation {
    condition     = length(trimspace(var.identity_name)) > 0
    error_message = "The Managed Identity name must not be empty."
  }
}

variable "resource_group_name" {
  description = "Name of the Resource Group containing the Container Apps resources."
  type        = string

  validation {
    condition     = length(trimspace(var.resource_group_name)) > 0
    error_message = "The Resource Group name must not be empty."
  }
}

variable "location" {
  description = "Azure region for the Container Apps resources."
  type        = string

  validation {
    condition     = length(trimspace(var.location)) > 0
    error_message = "The Azure region must not be empty."
  }
}

variable "infrastructure_subnet_id" {
  description = "Resource ID of the delegated subnet used by the Container Apps Managed Environment."
  type        = string

  validation {
    condition = can(regex(
      "/providers/Microsoft\\.Network/virtualNetworks/.+/subnets/.+$",
      var.infrastructure_subnet_id,
    ))

    error_message = "The infrastructure_subnet_id value must be a valid Azure subnet Resource ID."
  }
}

variable "container_registry_id" {
  description = "Resource ID of the Azure Container Registry containing the application image."
  type        = string

  validation {
    condition = can(regex(
      "/providers/Microsoft\\.ContainerRegistry/registries/.+$",
      var.container_registry_id,
    ))

    error_message = "The container_registry_id value must be a valid Azure Container Registry Resource ID."
  }
}

variable "container_registry_login_server" {
  description = "Login server hostname of the Azure Container Registry."
  type        = string

  validation {
    condition = can(regex(
      "^[a-z0-9]+\\.azurecr\\.io$",
      var.container_registry_login_server,
    ))

    error_message = "The Container Registry login server must use the expected registry.azurecr.io format."
  }
}

variable "container_registry_pull_role_name" {
  description = "Azure role that grants the Managed Identity permission to pull images from the registry."
  type        = string
  default     = "AcrPull"

  validation {
    condition = contains(
      [
        "AcrPull",
        "Container Registry Repository Reader",
      ],
      var.container_registry_pull_role_name,
    )

    error_message = "The registry pull role must be AcrPull or Container Registry Repository Reader."
  }
}

variable "container_image" {
  description = "Immutable container image reference including a sha256 digest."
  type        = string

  validation {
    condition = can(regex(
      "^[a-z0-9]+\\.azurecr\\.io/[a-z0-9._/-]+@sha256:[a-f0-9]{64}$",
      var.container_image,
    ))

    error_message = "The container image must be an immutable ACR reference ending with @sha256:<64 hexadecimal characters>."
  }
}

variable "target_port" {
  description = "Container port receiving application traffic."
  type        = number
  default     = 8000

  validation {
    condition     = var.target_port >= 1 && var.target_port <= 65535
    error_message = "The target port must be between 1 and 65535."
  }
}

variable "container_resources" {
  description = "CPU and memory allocated to the application container."
  type = object({
    cpu    = number
    memory = string
  })

  default = {
    cpu    = 0.25
    memory = "0.5Gi"
  }

  validation {
    condition = contains(
      [
        "0.25:0.5Gi",
        "0.5:1Gi",
        "0.75:1.5Gi",
        "1:2Gi",
        "1.25:2.5Gi",
        "1.5:3Gi",
        "1.75:3.5Gi",
        "2:4Gi",
      ],
      "${var.container_resources.cpu}:${var.container_resources.memory}",
    )

    error_message = "The selected CPU and memory values must form a supported Azure Container Apps Consumption combination."
  }
}

variable "scale" {
  description = "Minimum and maximum replica limits for the Container App."
  type = object({
    min_replicas = number
    max_replicas = number
  })

  default = {
    min_replicas = 0
    max_replicas = 1
  }

  validation {
    condition = (
      var.scale.min_replicas >= 0 &&
      var.scale.max_replicas >= 1 &&
      var.scale.max_replicas >= var.scale.min_replicas
    )

    error_message = "Replica limits must be non-negative, max_replicas must be at least 1, and max_replicas must be greater than or equal to min_replicas."
  }
}

variable "external_ingress_enabled" {
  description = "Controls whether the Container App is reachable through a public HTTPS endpoint."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags assigned to the Container Apps resources."
  type        = map(string)
  default     = {}
}

variable "environment_variables" {
  description = "Non-sensitive environment variables passed to the application container."
  type        = map(string)
  default     = {}

  validation {
    condition = alltrue([
      for name in keys(var.environment_variables) :
      can(regex("^[A-Z_][A-Z0-9_]*$", name))
    ])

    error_message = "Environment variable names must use uppercase letters, numbers, and underscores and must not start with a number."
  }
}
