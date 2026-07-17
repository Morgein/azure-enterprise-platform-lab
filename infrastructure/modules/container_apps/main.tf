resource "azurerm_user_assigned_identity" "this" {
  name                = var.identity_name
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = var.tags
}

resource "azurerm_role_assignment" "registry_pull" {
  scope                = var.container_registry_id
  role_definition_name = var.container_registry_pull_role_name
  principal_id         = azurerm_user_assigned_identity.this.principal_id
  principal_type       = "ServicePrincipal"

  description = "Allows the Container App managed identity to pull application images from Azure Container Registry."

  skip_service_principal_aad_check = true
}

resource "azurerm_container_app_environment" "this" {
  name                = var.environment_name
  resource_group_name = var.resource_group_name
  location            = var.location

  infrastructure_subnet_id       = var.infrastructure_subnet_id
  internal_load_balancer_enabled = false
  public_network_access          = "Enabled"
  zone_redundancy_enabled        = false

  workload_profile {
    name                  = "Consumption"
    workload_profile_type = "Consumption"
    minimum_count         = 0
    maximum_count         = 0
  }


  tags = var.tags
}

resource "azurerm_container_app" "this" {
  name                         = var.container_app_name
  resource_group_name          = var.resource_group_name
  container_app_environment_id = azurerm_container_app_environment.this.id
  revision_mode                = "Single"

  identity {
    type = "UserAssigned"

    identity_ids = [
      azurerm_user_assigned_identity.this.id,
    ]
  }

  registry {
    server   = var.container_registry_login_server
    identity = azurerm_user_assigned_identity.this.id
  }

  ingress {
    external_enabled           = var.external_ingress_enabled
    allow_insecure_connections = false
    target_port                = var.target_port
    transport                  = "http"

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
  template {
    min_replicas = var.scale.min_replicas
    max_replicas = var.scale.max_replicas

    container {
      name   = var.container_name
      image  = var.container_image
      cpu    = var.container_resources.cpu
      memory = var.container_resources.memory
      dynamic "env" {
        for_each = var.environment_variables

        content {
          name  = env.key
          value = env.value
        }
      }
      liveness_probe {
        transport = "HTTP"
        port      = var.target_port
        path      = "/health/live"

        initial_delay           = 10
        interval_seconds        = 30
        timeout                 = 5
        failure_count_threshold = 3
      }

      readiness_probe {
        transport = "HTTP"
        port      = var.target_port
        path      = "/health/ready"

        initial_delay           = 5
        interval_seconds        = 10
        timeout                 = 5
        failure_count_threshold = 3
        success_count_threshold = 1
      }
    }
  }

  tags = var.tags

  depends_on = [
    azurerm_role_assignment.registry_pull,
  ]
}
