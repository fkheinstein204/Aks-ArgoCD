output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.main.name
}

output "container_registry" {
  value = azurerm_container_registry.main.login_server
}
output "workload_managed_identity_id" {
  value = azurerm_user_assigned_identity.workload.client_id
}



output "kube_admin_config" {
  description = "Kubernetes Admin Credentials"
  sensitive   = true
  value       = azurerm_kubernetes_cluster.main.kube_admin_config
}


output "aks_credentials_command" {
  value = "az aks get-credentials --resource-group ${azurerm_resource_group.main.name} --name ${azurerm_kubernetes_cluster.main.name} --overwrite-existing"
}



output "client_certificate" {
  value     = azurerm_kubernetes_cluster.main.kube_config[0].client_certificate
  sensitive = true
}


output "oidc_issuer_url" {
  value = azurerm_kubernetes_cluster.main.oidc_issuer_url
}
output "workload_identity_id" {
  value = azurerm_user_assigned_identity.workload.id
}
output "workload_identity_client_id" {
  value = azurerm_user_assigned_identity.workload.client_id
}
output "workload_identity_name" {
  value = azurerm_user_assigned_identity.workload.name
}
output "workload_identity_resource_group_name" {
  value = azurerm_user_assigned_identity.workload.resource_group_name
}

output "dns_mi_identity_id" {
  value = azurerm_user_assigned_identity.external_dns.id
}

output "dns_mi_identity_client_id" {
  value = azurerm_user_assigned_identity.external_dns.client_id
}

output "aks_dns_mi_to_rg" {
  value = azurerm_role_assignment.aks_dns_mi_to_rg.scope
}

output "aks_dns_mi_to_zone" {
  value = azurerm_role_assignment.aks_dns_mi_to_zone.scope
}