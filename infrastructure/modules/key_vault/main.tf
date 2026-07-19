resource "azurerm_key_vault" "this" {
  #checkov:skip=CKV_AZURE_109:Public network access is temporarily required for controlled laboratory validation and remains protected by Azure RBAC.
  #checkov:skip=CKV_AZURE_189:Public network access will be replaced by a Private Endpoint during Phase 6 network hardening.
  #checkov:skip=CKV2_AZURE_32:A Private Endpoint is deferred to avoid permanent additional cost in the Azure for Students subscription.

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  sku_name            = lower(var.sku_name)

  rbac_authorization_enabled = true

  enabled_for_deployment          = false
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = false

  soft_delete_retention_days = var.soft_delete_retention_days
  purge_protection_enabled   = var.purge_protection_enabled

  public_network_access_enabled = var.public_network_access_enabled

  network_acls {
    bypass                     = var.network_bypass
    default_action             = var.network_default_action
    ip_rules                   = var.allowed_ip_rules
    virtual_network_subnet_ids = var.allowed_subnet_ids
  }

  tags = var.tags

  lifecycle {
    precondition {
      condition     = var.purge_protection_enabled
      error_message = "Purge protection must remain enabled for the Key Vault."
    }
  }
}

resource "azurerm_role_assignment" "application_secrets_user" {
  count = var.grant_application_secret_access ? 1 : 0

  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.application_identity_principal_id

  skip_service_principal_aad_check = true
}