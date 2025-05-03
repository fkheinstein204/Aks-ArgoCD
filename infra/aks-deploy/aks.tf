
resource "azurerm_role_assignment" "workload_identity" {
  scope                = azurerm_resource_group.main.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.workload.principal_id
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = local.cluster_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "demo-aks"
  kubernetes_version  = "1.31.7"
  node_resource_group = "${azurerm_resource_group.main.name}-nodes"

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  default_node_pool {
    name                        = "systempool"
    temporary_name_for_rotation = "syspool"
    node_count                  = 3
    vm_size                     = "Standard_D2_v2"
    zones                       = ["1", "2", "3"] # Multi-AZ support
  }



  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.workload.id]
  }

  network_profile {
    network_plugin      = "azure"
    load_balancer_sku   = "standard"
    network_data_plane  = "cilium"
    network_plugin_mode = "overlay"
    network_policy      = "cilium"

    dns_service_ip = var.aks_dns_service_ip
    service_cidr   = var.cidr_aks_service
    service_cidrs  = [var.cidr_aks_service]

    pod_cidrs = ["10.10.240.0/20"]
    pod_cidr  = "10.10.240.0/20"
  }

  tags = {
    Environment = "Production"
  }

}

resource "terraform_data" "aks-get-crdentials" {
  triggers_replace = [
    azurerm_kubernetes_cluster.main.id
  ]

  provisioner "local-exec" {
    command = "az aks get-credentials --resource-group ${azurerm_resource_group.main.name} --name ${azurerm_kubernetes_cluster.main.name} --overwrite-existing"
  }
}