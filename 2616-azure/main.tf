# locals {
#     name = "test"
# }

# provider "azurerm" {
#   features {}
# }


data "azurerm_subscription" "primary" {
}


# data "azurerm_client_config" "example" {
# }

# data "azurerm_resource_group" "sandbox" {
#     name = "test1"
# }


# resource "azurerm_role_assignment" "private_dns_zone_contributor_to_research_sandbox_aks" {
#   scope                = data.azurerm_subscription.primary.id  # Change to your resource scope
#   role_definition_name = "Reader"  # Change to the role you want to assign
#   principal_id         = data.azurerm_client_config.example.object_id  # Change to the user, service principal, or managed identity ID
# }

# module "research_sandbox" {
#   source               = "Azure/aks/azurerm"
#   version              = "9.3.0"
#   resource_group_name  = data.azurerm_resource_group.sandbox.name
#   tracing_tags_enabled = true
#   cluster_name                 = local.name
#   cluster_name_random_suffix   = true
#   prefix                       = local.name
# #   public_ssh_key               = local.public_ssh_key
#   sku_tier                     = "Free"
#   admin_username               = "admin"
#   automatic_channel_upgrade    = "stable"
#   agents_availability_zones    = ["1"]
#   agents_count                 = 3
#   agents_min_count             = 3
#   agents_max_count             = 6
#   agents_max_pods              = 50
#   enable_auto_scaling          = true
#   agents_size                  = "Standard_D2as_v5"
#   agents_pool_name             = "agents"
#   agents_type                  = "VirtualMachineScaleSets"
#   only_critical_addons_enabled = true
#   os_disk_type                 = "Ephemeral"
#   agents_pool_linux_os_configs = [
#     {
#       transparent_huge_page_enabled = "always"
#       sysctl_configs = [{
#         fs_aio_max_nr               = 65536
#         fs_file_max                 = 100000
#         fs_inotify_max_user_watches = 1000000
#       }]
#     }
#   ]
#   auto_scaler_profile_enabled         = true
#   auto_scaler_profile_scale_down_delay_after_add         = "5m" 
# #   rbac_aad_admin_group_object_ids     = [azuread_group.research_sandbox_aks_cluster_admins.object_id, data.azuread_service_principal.dask_gateway.object_id]
#   rbac_aad_azure_rbac_enabled         = true
#   rbac_aad_managed                    = true
#   rbac_aad                            = false
#   role_based_access_control_enabled   = true
#   log_analytics_workspace_enabled     = false
#   cluster_log_analytics_workspace_name = local.name
#   private_cluster_enabled             = true
#   private_cluster_public_fqdn_enabled = true
# #   private_dns_zone_id                 = data.azurerm_private_dns_zone.research_sandbox_cluster_api.id
#   network_policy                      = "cilium"
#   ebpf_data_plane                     = "cilium"
#   load_balancer_sku                   = "standard"
#   network_plugin                      = "azure"
#   network_plugin_mode                 = "overlay"
#   temporary_name_for_rotation         = "tmpnodepool1"
# #   vnet_subnet_id                      = data.azurerm_subnet.research_sandbox_aks_node_pool.id
# #   web_app_routing = {
# #     dns_zone_id = data.azurerm_private_dns_zone.sandbox_research.id
# #   }
# #   node_pools                         = local.nodes
#   net_profile_pod_cidr               = "10.224.0.0/14"
#   key_vault_secrets_provider_enabled = true
#   secret_rotation_enabled            = true
# #   attached_acr_id_map = {
# #     chronos = data.azurerm_container_registry.chronos.id
# #   }
# #   identity_ids  = [azurerm_user_assigned_identity.research_sandbox_aks_sandbox.id]
#   identity_type = "UserAssigned"
#   kubelet_identity = {
#   }

# #   network_contributor_role_assigned_subnet_ids = {
# #     node_pool_subnet = data.azurerm_subnet.research_sandbox_aks_node_pool.id
# #   }

#   oidc_issuer_enabled       = true
#   workload_identity_enabled = true

#   depends_on = [
#     azurerm_role_assignment.private_dns_zone_contributor_to_research_sandbox_aks,
#   ]
# }

module "foo" {
  count        = 3
  source       = "./foo"
  foo          = "magic"
  cluster_name = "something5"
}
