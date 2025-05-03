# DNS
data "azurerm_resource_group" "public_dns_zone" {
  name = var.dns_resource_group_name
}

data "azurerm_dns_zone" "dns" {
  name                = var.dns_zone_name
  resource_group_name = var.dns_resource_group_name
}

# external-dns managed identity
resource "azurerm_user_assigned_identity" "external_dns" {
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  name                = "mi-external-dns"
}

# reader on dns resource group
resource "azurerm_role_assignment" "aks_dns_mi_to_rg" {
  principal_id         = azurerm_user_assigned_identity.external_dns.principal_id
  role_definition_name = "Reader"
  scope                = data.azurerm_resource_group.public_dns_zone.id
  skip_service_principal_aad_check = true
}

# contributor on dns zone
resource "azurerm_role_assignment" "aks_dns_mi_to_zone" {
  principal_id         = azurerm_user_assigned_identity.external_dns.principal_id
  role_definition_name = "DNS Zone Contributor"
  scope                = data.azurerm_dns_zone.dns.id
  skip_service_principal_aad_check = true
}

resource "azurerm_federated_identity_credential" "dns" {
  name                = azurerm_user_assigned_identity.external_dns.name
  resource_group_name = azurerm_user_assigned_identity.external_dns.resource_group_name
  parent_id           = azurerm_user_assigned_identity.external_dns.id
  audience            = ["api://AzureADTokenExchange"]
  issuer              = azurerm_kubernetes_cluster.main.oidc_issuer_url
  subject             = "system:serviceaccount:${var.external_dns_namespace}:${var.external_dns_service_account_name}"

  depends_on = [azurerm_user_assigned_identity.external_dns]
}
