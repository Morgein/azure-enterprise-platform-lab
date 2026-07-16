output "deployment_context" {
  description = "Non-sensitive deployment context for the development environment."

  value = {
    environment         = var.environment
    location            = var.location
    name_prefix         = local.name_prefix
    compact_name_prefix = local.compact_name_prefix
    common_tags         = local.common_tags
  }
}
