

resource "azurerm_container_registry" "main" {
  name                = replace("acr${var.application_name}${var.environment_name}${random_string.main.result}", "-", "")
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Standard"
  admin_enabled       = false
}
