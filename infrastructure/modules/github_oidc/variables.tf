variable "identity_name" {
  description = "Name of the User Assigned Managed Identity used by GitHub Actions."
  type        = string

  validation {
    condition     = length(trimspace(var.identity_name)) > 0
    error_message = "The GitHub Actions identity name must not be empty."
  }
}

variable "federated_credential_name" {
  description = "Name of the Federated Identity Credential associated with the deployment identity."
  type        = string

  validation {
    condition     = length(trimspace(var.federated_credential_name)) > 0
    error_message = "The Federated Identity Credential name must not be empty."
  }
}

variable "resource_group_name" {
  description = "Name of the Resource Group where the deployment identity is created."
  type        = string
}

variable "location" {
  description = "Azure region where the deployment identity is created."
  type        = string
}

variable "github_repository" {
  description = "Immutable GitHub repository identity in owner@owner_id/repository@repository_id format."
  type        = string

  validation {
    condition = can(regex(
      "^[^/@]+@[0-9]+/[^/@]+@[0-9]+$",
      var.github_repository,
    ))

    error_message = "The GitHub repository identity must use the owner@owner_id/repository@repository_id format."
  }
}

variable "github_environment" {
  description = "GitHub Environment trusted by the Federated Identity Credential."
  type        = string

  validation {
    condition     = length(trimspace(var.github_environment)) > 0
    error_message = "The GitHub Environment name must not be empty."
  }
}

variable "container_registry_id" {
  description = "Resource ID of the Azure Container Registry where the pipeline pushes images."
  type        = string
}

variable "container_app_id" {
  description = "Resource ID of the Azure Container App updated by the deployment pipeline."
  type        = string
}

variable "tags" {
  description = "Tags applied to the GitHub Actions deployment identity."
  type        = map(string)
  default     = {}
}