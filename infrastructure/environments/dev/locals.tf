locals {
  name_prefix = lower(
    join(
      "-",
      [
        "aeplab",
        var.workload_name,
        var.environment
      ]
    )
  )

  compact_name_prefix = replace(
    local.name_prefix,
    "-",
    ""
  )

  mandatory_tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "Azure Enterprise Platform Lab"
    Repository  = "azure-enterprise-platform-lab"
    Workload    = var.workload_name
    CostProfile = "StudentLab"
  }

  common_tags = merge(
    local.mandatory_tags,
    var.additional_tags
  )
}
