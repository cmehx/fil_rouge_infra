resource "azurerm_resource_group" "resourcegroups" {
  for_each = toset(var.environments)
  name     = "${var.ResourceGroup}_${each.key}"
  location = var.Location
}

resource "azurerm_container_registry" "acr" {
  for_each            = toset(var.environments)
  name                = "${var.ContainerRegistryName}${title(each.key)}"
  resource_group_name = "${var.ResourceGroup}_${each.key}"
  location            = var.Location
  sku                 = var.ContainerRegistrySKU
  admin_enabled       = false
}

resource "azurerm_key_vault" "keyvault" {
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
}
