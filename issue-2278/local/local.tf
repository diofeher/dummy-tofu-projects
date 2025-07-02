locals {
  mod_items = toset(["a", "b", "c"])
}

resource "random_string" "dynamic" {
  for_each = local.mod_items
  length   = 4
}
