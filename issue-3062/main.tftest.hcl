mock_provider "azurerm" {
  mock_resource "azurerm_data_protection_backup_vault" {
    defaults = {
      id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.DataProtection/backupVaults/backupVaultName"
       identity = {
         tenant_id = "12345678-4321-9876-4563-123456789012"
         principal_id = "12345678-4321-9876-4563-123456789012"
       }
    }
  }
}

run "full_configuration" {

  command = apply

  assert {
    condition     = azurerm_data_protection_backup_vault.this.name == "mock-unittest"
    error_message = "Unexpected value"
  }
}
