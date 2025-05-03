
locals {
  cluster_name = "aks-${var.application_name}-${random_string.main.result}"
}

resource "random_string" "main" {
  length  = 8
  upper   = false
  special = false
}

resource "azurerm_resource_group" "main" {
  name     = "rg-${var.application_name}-${var.environment_name}-${random_string.main.result}"
  location = var.location
  tags = {
    environment = var.environment_name
    application = var.application_name
  }
}
