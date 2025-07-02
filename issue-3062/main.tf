resource "azurerm_data_protection_backup_vault" "this" {
  name                = "mock-unittest"
  location            = "mock-unittest-vault"
  resource_group_name = "resource-group-name"
  datastore_type      = "VaultStore"
  redundancy          = "LocallyRedundant"
  identity {
    type = "SystemAssigned"
  }
}

terraform {
  required_version = "~> 1.9"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.35.0"
    }
  }
}
