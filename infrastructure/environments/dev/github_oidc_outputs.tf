output "github_oidc_configuration" {
  description = "Sensitive GitHub Actions Azure OIDC configuration."
  sensitive   = true

  value = {
    identity_name      = module.github_oidc.identity_name
    client_id          = module.github_oidc.client_id
    tenant_id          = module.github_oidc.tenant_id
    subscription_id    = module.github_oidc.subscription_id
    federated_subject  = module.github_oidc.federated_subject
    github_environment = module.github_oidc.github_environment
  }
}