variable "name" {
  description = "Name of the Azure Subscription Budget."
  type        = string

  validation {
    condition = (
      length(trimspace(var.name)) >= 3 &&
      length(trimspace(var.name)) <= 63
    )

    error_message = "The budget name must be between 3 and 63 characters long."
  }
}

variable "subscription_id" {
  description = "Azure Subscription ID monitored by the budget."
  type        = string

  validation {
    condition = can(
      regex(
        "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$",
        var.subscription_id,
      )
    )

    error_message = "The subscription_id value must be a valid Azure Subscription UUID."
  }
}

variable "amount" {
  description = "Maximum expected monthly spending amount for the subscription budget."
  type        = number
  default     = 10

  validation {
    condition     = var.amount > 0
    error_message = "The monthly budget amount must be greater than zero."
  }
}

variable "start_date" {
  description = "Start date of the budget period in RFC3339 format. The date should be the first day of a month."
  type        = string

  validation {
    condition = can(
      regex(
        "^[0-9]{4}-[0-9]{2}-01T00:00:00Z$",
        var.start_date,
      )
    )

    error_message = "The start_date value must use RFC3339 format and the first day of a month, for example 2026-07-01T00:00:00Z."
  }
}

variable "end_date" {
  description = "End date of the budget period in RFC3339 format. The date should be the first day of a month."
  type        = string

  validation {
    condition = can(
      regex(
        "^[0-9]{4}-[0-9]{2}-01T00:00:00Z$",
        var.end_date,
      )
    )

    error_message = "The end_date value must use RFC3339 format and the first day of a month, for example 2027-07-01T00:00:00Z."
  }
}

variable "contact_emails" {
  description = "Email addresses that receive Azure Cost Management budget notifications."
  type        = list(string)
  sensitive   = true

  validation {
    condition = (
      length(var.contact_emails) > 0 &&
      alltrue([
        for email in var.contact_emails :
        can(regex("^[^@[:space:]]+@[^@[:space:]]+\\.[^@[:space:]]+$", email))
      ])
    )

    error_message = "At least one valid notification email address must be provided."
  }
}