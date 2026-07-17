variable "name" {
  description = "Globally unique name of the Azure Container Registry."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{5,50}$", var.name))
    error_message = "The Container Registry name must contain only lowercase letters and numbers and must be between 5 and 50 characters long."
  }
}

variable "resource_group_name" {
  description = "Name of the Resource Group where the Azure Container Registry is created."
  type        = string

  validation {
    condition     = length(trimspace(var.resource_group_name)) > 0
    error_message = "The Resource Group name must not be empty."
  }
}

variable "location" {
  description = "Azure region where the Azure Container Registry is created."
  type        = string

  validation {
    condition     = length(trimspace(var.location)) > 0
    error_message = "The Azure region must not be empty."
  }
}

variable "sku" {
  description = "Service tier of the Azure Container Registry."
  type        = string
  default     = "Basic"

  validation {
    condition = contains(
      [
        "Basic",
        "Standard",
        "Premium",
      ],
      var.sku,
    )

    error_message = "The Container Registry SKU must be Basic, Standard, or Premium."
  }
}

variable "public_network_access_enabled" {
  description = "Controls whether the registry is accessible through its public endpoint."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags assigned to the Azure Container Registry."
  type        = map(string)
  default     = {}
}