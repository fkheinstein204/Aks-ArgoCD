resource "azurerm_key_vault" "main" {
  name                      = "kv-${var.application_name}-${var.environment_name}-${random_string.main.result}"
  location                  = azurerm_resource_group.main.location
  resource_group_name       = azurerm_resource_group.main.name
  tenant_id                 = data.azurerm_client_config.this.tenant_id
  sku_name                  = "standard"
  enable_rbac_authorization = true
  #public_network_access_enabled = false
  purge_protection_enabled = false
}

#resource "azurerm_key_vault_secret" "sauce" {
#  name         = "username-db"
#  value        = "Password123"
#  key_vault_id = azurerm_key_vault.main.id

#  depends_on = [azurerm_key_vault.main]
#}


resource "azurerm_role_assignment" "terraform_keyvault_access" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.this.object_id
}

resource "azurerm_role_assignment" "workload_identity_keyvault" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.workload.principal_id
}

