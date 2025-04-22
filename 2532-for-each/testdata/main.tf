resource "null_resource" "resource" {}

locals {
  follow = {
    (null_resource.resource.id) : "follow"
  }
}

resource "null_resource" "a" {
  for_each = local.follow
}
