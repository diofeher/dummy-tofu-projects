variable "enable" {
  type    = bool
  default = true
}

locals {
  users = ["diogenes-test-a-group", "diogenes-test-b-group"]
}

module "example" {
  source = "./mod1"
  # count = var.enable ? 1 : 0
  enable = var.enable
  lifecycle {
    enabled = true
  }
}

moved {
  from = module.example[0]
  to   = module.example
}

# output "module_output" {
#   value = module.example.output
# }
