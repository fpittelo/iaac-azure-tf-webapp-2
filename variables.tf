#### variable for subscription_id ####
variable "subscription_id" {
  type    = string
  default = "a6f24a81-7804-44a9-b074-25a9781afd24"
}

#### variable for client_id ####
variable "client_id" {
  type    = string
  default = "60ab9702-ec7c-4c22-a97b-99ca2dd561b9"
}

#### variable for tenant_id ####
variable "tenant_id" {
  type    = string
  default = "4c8896b7-52b2-4cb4-9533-1dc0c937e1ed"
}

#### variable for client_secret ####
variable "client_secret" {
  type    = string
  default = "J1X8Q~CafN2rr5oy0xW5FiB1GKY~gmk9uQhCectv"
}

variable "wap_rg_name" {
  type    = string
  default = "iaac-azure-tf-webapp2"
}

variable "wap_rg_location" {
  type    = string
  default = "Switzerland North"
}

variable "owner" {
  type    = string
  default = "Fred"
}

variable "department" {
  type    = string
  default = "IT"
}

variable "wap_status_dv" {
  type    = string
  default = "Dev"
}

variable "backend_address_pool_name" {
  default = "wap-be-pool"
}

variable "frontend_port_name" {
  default = "wap-fe-port"
}

variable "frontend_ip_configuration_name" {
  default = "wap-feip"
}

variable "http_setting_name" {
  default = "wap-http-setting"
}

variable "listener_name" {
  default = "wap-listener"
}

variable "request_routing_rule_name" {
  default = "wap-routing-rule"
}

variable "redirect_configuration_name" {
  default = "wap-redirect-conf"
}

locals {
  diag_appgw_logs = [
    "ApplicationGatewayAccessLog",
    "ApplicationGatewayPerformanceLog",
    "ApplicationGatewayFirewallLog",
  ]
  diag_appgw_metrics = [
    "AllMetrics",
  ]
}