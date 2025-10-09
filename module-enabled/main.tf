variable "on" {
  type    = bool
  default = true
}

module "child" {
  source = "./child"
  # count  = 1

  # lifecycle {
  #   enabled = var.on
  # }

  # for_each = {
  #   for i in range(15) : i => i
  # }

}

output "result" {
  // This is in a 1-tuple just because OpenTofu treats a fully-null
  // root module output value as if it wasn't declared at all,
  // but we want to make sure we're actually testing the result
  // of this resource directly.
  value = [try(module.child.result, "")]
}
