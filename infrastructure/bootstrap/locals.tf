locals {
  resource_group_name = "rg-aeplab-tfstate-${var.location}"

  generated_storage_account_name = nonsensitive(
    lower(
      "staeplab${substr(md5(var.subscription_id), 0, 8)}"
    )
  )

  storage_account_name = coalesce(
    var.storage_account_name_override,
    local.generated_storage_account_name
  )

  mandatory_tags = {
    ManagedBy   = "Terraform"
    Project     = "Azure Enterprise Platform Lab"
    Repository  = "azure-enterprise-platform-lab"
    Purpose     = "TerraformRemoteState"
    CostProfile = "StudentLab"
  }

  common_tags = merge(
    local.mandatory_tags,
    var.additional_tags
  )
}
