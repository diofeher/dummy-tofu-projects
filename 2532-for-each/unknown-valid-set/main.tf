variable "additional_networks" {
  type        = set(string)
  description = "(Optional) List of additional networks to attach to this network. Destinations to these networks must be explicitly configured."
  default = [
    "a", "b", "c"
  ]
}

resource "null_resource" "a" {
  for_each = var.additional_networks
}
