resource "azurerm_resource_group" "resourcegroups" {
  for_each = toset(var.environments)
  name     = "${var.ResourceGroup}_${each.key}"
  location = var.Location
  tags = {
    Environment = "Terraform Getting Started"
    Team        = "DevOps"
  }
}

resource "azurerm_container_registry" "acr" {
    
  for_each            = toset(var.environments)
  name                = "${var.ContainerRegistryName}${title(each.key)}"
  resource_group_name = "${var.ResourceGroup}_${each.key}"
  location            = var.Location
  sku                 = var.ContainerRegistrySKU
  admin_enabled       = false
}

