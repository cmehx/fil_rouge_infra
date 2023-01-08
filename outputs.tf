output "resource_group_names" {
  value = azurerm_resource_group.resourcegroups.name
}

output "kubernetes_acr_names" {
  value = azurerm_container_registry.acrs.name
}

output "azurerm_key_vault_names" {
  value = azurerm_key_vault.keyvaults.name
}

output "kubernetes_cluster_names" {
  value = azurerm_kubernetes_cluster.clusters.name
}
output "client_certificate" {
  value     = azurerm_kubernetes_cluster.example.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.example.kube_config_raw
  sensitive = true
}