resource "azurerm_resource_group" "resourcegroups" {
    name        = "${var.ResourceGroup}_${var.environment}"
    location    = var.Location
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.ContainerRegistryName}_${var.environment}"
  resource_group_name = "${var.ResourceGroup}_${var.environment}"
  location            = var.Location
  sku                 = var.ContainerRegistrySKU
  admin_enabled       = false
}