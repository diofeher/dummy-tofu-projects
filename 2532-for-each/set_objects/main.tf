variable "additional_networks" {
  type = set(object({
    name        = string
    route_cidrs = set(string)
  }))
  description = "(Optional) List of additional networks to attach to this network. Destinations to these networks must be explicitly configured."
  default     = []
}

resource "null_resource" "a" {
  for_each = var.additional_networks

  triggers = {
    cluster_instance_ids = each.value.a
  }
}
