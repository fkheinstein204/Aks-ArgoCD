variable "application_name" {
  type = string
}
variable "environment_name" {
  type    = string
  default = "dev"
}
variable "location" {
  type    = string
  default = "westeurope"
}

variable "k8s_service_account_name" {
  type = string
}

variable "k8s_namespace" {
  type = string
}

variable "external_dns_namespace" {
  type    = string
  default = "external-dns"
}

variable "external_dns_service_account_name" {
  type    = string
  default = "external-dns"
}

variable "cidr_aks_service" {
  description = "CIDR notation IP range from which to assign service cluster IPs"
  default     = "10.0.0.0/16"
}

variable "aks_dns_service_ip" {
  description = "DNS server IP address"
  default     = "10.0.0.10"
}


# DNS
variable "dns_resource_group_name" {
  default = "__DNS_RG_NAME__"
}

variable "dns_zone_name" {
  default = "__ROOT_DOMAIN_NAME__"
}

