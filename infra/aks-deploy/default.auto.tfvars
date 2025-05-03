application_name = "k8sinfra"
#location         = "westeurope"
#location         = "eastus"
location = "swedencentral"

environment_name = "dev"

k8s_namespace            = "app"
k8s_service_account_name = "workload"

external_dns_namespace            = "external-dns"
external_dns_service_account_name = "external-dns"


dns_resource_group_name = "rg-azure-dns"
dns_zone_name           = "wheezy.cloud"

