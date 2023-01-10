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
resource "azurerm_log_analytics_workspace" "law" {
  name                = "fil-rouge-${var.environment}-law"
  resource_group_name = azurerm_resource_group.resourcegroups.name
  location            = azurerm_resource_group.resourcegroups.location
  sku                 = "PerGB2018"

  depends_on = [
    azurerm_resource_group.resourcegroups
  ]
}
resource "azurerm_storage_account" "storage" {
  name                     = "filrouge${var.environment}"
  resource_group_name      = azurerm_resource_group.resourcegroups.name
  location                 = azurerm_resource_group.resourcegroups.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [
    azurerm_resource_group.resourcegroups
  ]
}
resource "azurerm_log_analytics_storage_insights" "lasi" {
  name                = "fil-rouge-${var.environment}-lasi"
  resource_group_name = azurerm_resource_group.resourcegroups.name
  workspace_id        = azurerm_log_analytics_workspace.law.id

  storage_account_id  = azurerm_storage_account.storage.id
  storage_account_key = azurerm_storage_account.storage.primary_access_key

  depends_on = [
    azurerm_resource_group.resourcegroups,
    azurerm_log_analytics_workspace.law,
    azurerm_storage_account.storage
  ]
}

resource "azurerm_log_analytics_solution" "las" {
  solution_name         = "Containers"
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name
  location              = azurerm_resource_group.resourcegroups.location
  resource_group_name   = azurerm_resource_group.resourcegroups.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/Containers"
  }

  depends_on = [
    azurerm_resource_group.resourcegroups,
    azurerm_log_analytics_workspace.law
  ]
}
resource "azurerm_kubernetes_cluster" "clusters" {
  name                = "fil-rouge-aks-${var.environment}"
  location            = azurerm_resource_group.resourcegroups.location
  resource_group_name = azurerm_resource_group.resourcegroups.name
  dns_prefix          = "fil-rouge-${var.environment}-k8s"
  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }
  default_node_pool {
    name                = "default"
    vm_size             = "Standard_D2_v2"
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 2
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
  }
  tags = {
    environment = var.environment
  }

  depends_on = [
    azurerm_resource_group.resourcegroups,
    azurerm_log_analytics_workspace.law
  ]
}

/* resource "azurerm_role_assignment" "kube_to_acr" {
  principal_id         = azurerm_kubernetes_cluster.clusters.identity.principal_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acrs.id

  depends_on = [
    azurerm_container_registry.acrs,
    azurerm_kubernetes_cluster.clusters
  ]
}
 */