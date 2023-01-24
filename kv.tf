############## Key Vault ##################



data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "wap-vault" {
  name = "wap-vault"
  location = var.wap_rg_location
  resource_group_name = var.wap_rg_name
  tenant_id = var.tenant_id
  #soft_delete_enabled = true
  soft_delete_retention_days = 90
  purge_protection_enabled = false
  sku_name = "standard"
  tags = azurerm_resource_group.rg1.tags

    network_acls {
      default_action = "Deny"
      bypass         = "AzureServices"
    }

}

resource "azurerm_key_vault_access_policy" "builder" {
  key_vault_id = azurerm_key_vault.wap-vault.id
  tenant_id = azurerm_key_vault.wap-vault.tenant_id
  object_id = azurerm_user_assigned_identity.wap.principal_id
  
  certificate_permissions = [
    "Create",
    "Get",
    "List"
  ]
}

resource "azurerm_key_vault_access_policy" "wap" {
  key_vault_id = azurerm_key_vault.wap-vault.id
  tenant_id = azurerm_key_vault.wap-vault.tenant_id
  object_id = azurerm_user_assigned_identity.wap.principal_id
  
  secret_permissions = [
    "Get",
  ]
}

resource "azurerm_key_vault_certificate" "wap-certificate" {
  name = "wap-certificate"
  key_vault_id = azurerm_key_vault.wap-vault.id

  certificate_policy {
    issuer_parameters {
        name = "Self"
    }

    key_properties {
      exportable = true
      key_size = 2048
      key_type = "RSA"
      reuse_key = true
    }
  
    lifetime_action {
      action {
        action_type = "AutoRenew"
    }
    
    trigger {
        days_before_expiry = 30
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      # Server Authentication = 1.3.6.1.5.5.7.3.1
      # Client Authentication = 1.3.6.1.5.5.7.3.2
      extended_key_usage = ["1.3.6.1.5.5.7.3.1"]
  
      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]
      
      subject_alternative_names {
        dns_names = ["mysite1.com"]
      }

      subject            = "CN=mysite1.com"
      validity_in_months = 12
      }
  }
}