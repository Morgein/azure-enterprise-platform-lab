output "id" {
  description = "Resource ID of the Azure Subscription Budget."
  value       = azurerm_consumption_budget_subscription.this.id
}

output "name" {
  description = "Name of the Azure Subscription Budget."
  value       = azurerm_consumption_budget_subscription.this.name
}

output "amount" {
  description = "Configured monthly spending amount of the Azure Subscription Budget."
  value       = azurerm_consumption_budget_subscription.this.amount
}

output "time_grain" {
  description = "Time grain used to evaluate the Azure Subscription Budget."
  value       = azurerm_consumption_budget_subscription.this.time_grain
}

output "period" {
  description = "Configured start and end dates of the Azure Subscription Budget."

  value = {
    start_date = var.start_date
    end_date   = var.end_date
  }
}

output "actual_notification_thresholds" {
  description = "Actual cost percentages that trigger budget notifications."
  value       = [50, 75, 90]
}

output "forecasted_notification_threshold" {
  description = "Forecasted cost percentage that triggers a budget notification."
  value       = 100
}