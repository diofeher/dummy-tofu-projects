locals {
  items = toset(["a", "b"])
}

resource "random_uuid" "this" {
  for_each = local.items
}

import {
  to = random_uuid.this["asdsdas"]
  id = "123"
}
