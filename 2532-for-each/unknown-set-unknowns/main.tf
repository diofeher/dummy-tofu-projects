# variables.tf of the module
variable "s" {
  type = set(object({
    eu-central-1a = string
  }))
}

resource "null_resource" "c" {
  for_each = var.s
}
