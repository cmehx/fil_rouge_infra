resource "azurerm_resource_group" "resourcegroups" {
  for_each = toset(var.environments)
  name     = "${var.ResourceGroup}_${each.key}"
  location = var.Location
  tags = {
    environment = each.key
  }
}

resource "azurerm_container_registry" "acrs" {
  for_each            = toset(var.environments)
  name                = "${var.ContainerRegistryName}${title(each.key)}"
  resource_group_name = "${var.ResourceGroup}_${each.key}"
  location            = var.Location
  sku                 = var.ContainerRegistrySKU
  admin_enabled       = false
  tags = {
    environment = each.key
  }
  depends_on = [
    azurerm_resource_group.resourcegroups
  ]
}

resource "azurerm_key_vault" "keyvaults" {
  for_each                    = toset(var.environments)
  name                        = "${var.KeyVaultName}${title(each.key)}"
  location                    = var.Location
  resource_group_name         = "${var.ResourceGroup}_${each.key}"
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
    environment = each.key
  }
  depends_on = [
    azurerm_resource_group.resourcegroups
  ]
}
resource "azurerm_kubernetes_cluster" "clusters" {
  for_each            = toset(var.environments)
  name                = "fil-rouge-aks-${each.key}"
  location            = var.Location
  resource_group_name = "${var.ResourceGroup}_${each.key}"
  dns_prefix          = "fil-rouge-${each.key}-k8s"

  default_node_pool {
    name                = "default"
    vm_size             = "Standard_D2_v2"
    type                = "VirtualMachineScaleSets"
    os_disk_size_gb     = 30
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 2
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  tags = {
    environment = each.key
  }

  depends_on = [
    azurerm_resource_group.resourcegroups
  ]
}