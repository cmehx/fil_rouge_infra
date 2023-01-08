resource "azurerm_resource_group" "resourcegroups" {
  name     = "${var.ResourceGroup}_${var.environment}"
  location = var.Location
  tags = {
    environment = var.environment
  }
}
resource "azurerm_container_registry" "acrs" {
  name                = "${var.ContainerRegistryName}${title(var.environment)}"
  resource_group_name = azurerm_resource_group.resourcegroups.name
  location            = azurerm_resource_group.resourcegroups.location
  sku                 = var.ContainerRegistrySKU
  admin_enabled       = false
  tags = {
    environment = var.environment
  }
  depends_on = [
    azurerm_resource_group.resourcegroups
  ]
}
resource "azurerm_key_vault" "keyvaults" {
  name                        = "${var.KeyVaultName}${title(var.environment)}"
  location                    = azurerm_resource_group.resourcegroups.location
  resource_group_name         = azurerm_resource_group.resourcegroups.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  enabled_for_disk_encryption = true
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = var.KeyVaultSKU
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    key_permissions = [
      "Get",
    ]
    secret_permissions = [
      "Get",
    ]
    storage_permissions = [
      "Get",
    ]
  }
  tags = {
    environment = var.environment
  }
  depends_on = [
    azurerm_resource_group.resourcegroups
  ]
}
resource "azurerm_log_analytics_workspace" "insights" {
  name                = "fil-rouge-logs-${var.environment}"
  location            = azurerm_resource_group.resourcegroups.location
  resource_group_name = azurerm_resource_group.resourcegroups.name
  retention_in_days   = 30
}

resource "azurerm_kubernetes_cluster" "clusters" {
  name                = "fil-rouge-aks-${var.environment}"
  location            = azurerm_resource_group.resourcegroups.location
  resource_group_name = azurerm_resource_group.resourcegroups.name
  dns_prefix          = "fil-rouge-${var.environment}-k8s"

  addon_profile {
    azure_policy { enabled = true }
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.insights.id
    }
  }

  identity { type = "SystemAssigned" }
  default_node_pool {
    name                = "default"
    vm_size             = "Standard_D2_v2"
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 1
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  tags = {
    environment = var.environment
  }

  depends_on = [
    azurerm_resource_group.resourcegroups
  ]
}