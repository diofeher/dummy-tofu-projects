locals {
  instances = {
    "a" = 1
  }
}

provider "null" {
  alias    = "blah"
  for_each = local.instances
}
