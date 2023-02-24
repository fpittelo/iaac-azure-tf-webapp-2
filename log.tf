##### Log Analytics workspace

resource "azurerm_log_analytics_workspace" "wap_logs" {
  name                = "wap-logs"
  location            = var.wap_rg_location
  resource_group_name = var.wap_rg_name
  sku                 = "PerGB2018"
  retention_in_days   = "30"
  depends_on          = [azurerm_resource_group.rg1]

  tags = {
    owner  = var.owner
    dept   = var.department
    status = var.wap_status_dv
  }

}

resource "azurerm_log_analytics_solution" "wap" {
  solution_name         = "AzureAppGatewayAnalytics"
  location              = var.wap_rg_location
  resource_group_name   = var.wap_rg_name
  workspace_resource_id = azurerm_log_analytics_workspace.wap_logs.id
  workspace_name        = azurerm_log_analytics_workspace.wap_logs.name
  tags                  = azurerm_log_analytics_workspace.wap_logs.tags

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/AzureAppGatewayAnalytics"
  }

}