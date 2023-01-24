######### Managed Service Identity ###########

resource "azurerm_user_assigned_identity" "wap" {
  name                           = "wap-msi"
  location                       = var.wap_rg_location
  resource_group_name            = var.wap_rg_name
  tags                           = azurerm_resource_group.rg1.tags
}