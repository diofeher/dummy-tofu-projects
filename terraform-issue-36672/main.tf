# resource "azurerm_app_service_custom_hostname_binding" "mijn_staging_rdc_nl" {
#   count               = var.web_app_slot_count
#   hostname            = "mijn${var.environment_suffix}-staging.rdc.nl"
#   app_service_name    = "${module.appservice_mijnrdc.name}/staging"
#   resource_group_name = data.azurerm_resource_group.app.name
#   ssl_state           = module.bovemij.azurerm_app_service_custom_hostname_binding.ssl_state.sni_enabled
#   thumbprint          = data.azurerm_key_vault_certificate.ssl_certificate_staging[0].thumbprint
# }

# import {
#   for_each = azurerm_app_service_custom_hostname_binding.mijn_staging_rdc_nl
#   id       = "/subscriptions/70a78144-133c-4b49-a2e2-8dce46cfc325/resourceGroups/bov-mijnrdc-acc-we-app-rg-001/providers/Microsoft.Web/sites/bov-mrdc-acc-mijnrdc-we-app-001/hostNameBindings/mijn-acc-staging.rdc.nl"
#   to       = azurerm_app_service_custom_hostname_binding.mijn_staging_rdc_nl[each.key]
# }

resource "random_id" "server" {
  count       = 8
  byte_length = 8
}

import {
  for_each = random_id.server
  id       = random_id.server[each.key].id
  to       = random_id.server[each.key]
}
