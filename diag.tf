############# Diagnostic #########################

resource "azurerm_monitor_diagnostic_setting" "wap-diag" {
  name = "wap-diag"
  target_resource_id = azurerm_application_gateway.network.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.wap_logs.id
  
  dynamic "log" {
    for_each = local.diag_appgw_logs
    content {
      category = log.value

      retention_policy {
        enabled = false
      }
    }
  }

  dynamic "metric" {
    for_each = local.diag_appgw_metrics
    content {
      category = metric.value

      retention_policy {
        enabled = false
      }
    }
  }
}