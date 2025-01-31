# main.tf

# ------------------------------
# Resource Group
# ------------------------------
resource "azurerm_resource_group" "rg" {
  name     = "rg-sgbeta-api-exploration-003"
  location = var.az_region
}

# ------------------------------
# Azure Container Registry (ACR)
# ------------------------------
resource "azurerm_container_registry" "acr" {
  name                = "crapiexploration"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.az_region
  sku                 = "Basic"
  admin_enabled       = true
}

# ------------------------------
# Log Analytics Workspace (for monitoring)
# ------------------------------
resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "law-api-exploration-001"
  location            = var.az_region
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# ------------------------------
# Azure Container App Environment
# ------------------------------
resource "azurerm_container_app_environment" "container_env" {
  name                = "cae-api-exploration-001"
  location            = var.az_region
  resource_group_name = azurerm_resource_group.rg.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics.id
}

# ------------------------------
# Azure Container App
# ------------------------------
# resource "azurerm_container_app" "container_app" {
#   name                = "ca-flask-api-001"
#   resource_group_name = azurerm_resource_group.rg.name
#   container_app_environment_id = azurerm_container_app_environment.container_env.id
#   revision_mode = "Single"

#   template {
#     container {
#       name   = "flask-api"
#       image  = "${azurerm_container_registry.acr.login_server}/flask-api:latest"
#       cpu    = "0.5"
#       memory = "1.0Gi"
#     }
#   }
# }

#   identity {
#     type = "SystemAssigned"
#   }

#   configuration {
#     ingress {
#       external_enabled = true
#       target_port      = 5000  # Flask default port
#     }

#     dapr {
#       enabled = false
#     }
#   }

#       env {
#         name  = "FLASK_ENV"
#         value = "production"
#       }
#     }

#     scale {
#       min_replicas = 1
#       max_replicas = 3
#     }
#   }


# ------------------------------
# Role Assignment (Container Registry Pull)
# ------------------------------
# resource "azurerm_role_assignment" "acr_pull" {
#   scope                = azurerm_container_registry.acr.id
#   role_definition_name = "AcrPull"
#   principal_id         = azurerm_container_app.container_app.identity[0].principal_id
# }
