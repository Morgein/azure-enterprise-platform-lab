resource "azurerm_resource_group" "state" {
  name     = local.resource_group_name
  location = var.location
  tags     = local.common_tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_storage_account" "state" {
  #checkov:skip=CKV_AZURE_206:Non-production student lab uses cost-optimized LRS for Terraform state.
  #checkov:skip=CKV_AZURE_33:Queue service is not used by the Terraform state backend.
  #checkov:skip=CKV_AZURE_59:Public endpoint is required by the student workstation; access is protected by Microsoft Entra ID RBAC.
  #checkov:skip=CKV2_AZURE_33:Private Endpoint requires private runner connectivity that is outside the student-lab scope.
  #checkov:skip=CKV2_AZURE_1:Microsoft-managed encryption and infrastructure encryption are sufficient for non-production state.

  name                = local.storage_account_name
  resource_group_name = azurerm_resource_group.state.name
  location            = var.storage_account_location

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Hot"

  min_tls_version                   = "TLS1_2"
  https_traffic_only_enabled        = true
  allow_nested_items_to_be_public   = false
  public_network_access_enabled     = true
  shared_access_key_enabled         = false
  default_to_oauth_authentication   = true
  cross_tenant_replication_enabled  = false
  infrastructure_encryption_enabled = true

  blob_properties {
    versioning_enabled = true

    delete_retention_policy {
      days = var.soft_delete_retention_days
    }

    container_delete_retention_policy {
      days = var.soft_delete_retention_days
    }
  }

  tags = local.common_tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_role_assignment" "state_admin" {
  scope                = azurerm_storage_account.state.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.state_admin_principal_id
}

resource "azurerm_storage_container" "state" {
  #checkov:skip=CKV2_AZURE_21:Additional Blob read logging is outside the cost-controlled student-lab scope.

  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.state.id
  container_access_type = "private"

  depends_on = [
    azurerm_role_assignment.state_admin
  ]

  lifecycle {
    prevent_destroy = true
  }
}