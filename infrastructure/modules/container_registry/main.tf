resource "azurerm_container_registry" "this" {
  #checkov:skip=CKV_AZURE_165:Single-region development deployment does not require Premium geo-replication.
  #checkov:skip=CKV_AZURE_163:Container images are scanned by Trivy in the pull request security workflow.
  #checkov:skip=CKV_AZURE_164:Docker Content Trust is deprecated; modern image signing will be implemented with Notation.
  #checkov:skip=CKV_AZURE_139:Public endpoint is required by GitHub-hosted runners; authentication uses OIDC and managed identities.
  #checkov:skip=CKV_AZURE_237:Dedicated data endpoints require Premium ACR and are outside the student-lab budget.
  #checkov:skip=CKV_AZURE_166:Trivy provides the vulnerability scanning control for the cost-controlled development registry.
  #checkov:skip=CKV_AZURE_233:Zone redundancy requires Premium ACR and is not required for a single-region development environment.
  #checkov:skip=CKV_AZURE_167:Automated untagged manifest retention is deferred for the low-volume student registry.

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku

  admin_enabled                 = false
  anonymous_pull_enabled        = false
  public_network_access_enabled = var.public_network_access_enabled

  tags = var.tags
}