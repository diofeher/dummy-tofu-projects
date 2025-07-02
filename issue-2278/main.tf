locals {
  items = toset(["a", "b", "c"])
}

resource "random_string" "dynamic" {
  for_each = local.items

  length = 4
}


module "mod" {
  source = "./local"
}
