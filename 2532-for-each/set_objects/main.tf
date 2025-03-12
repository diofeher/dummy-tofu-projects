variable "set_objects" {
  type = set(object({ a = string }))

  default = [
    { a = 1 }, { a = 1 }
  ]
}

resource "null_resource" "a" {
  for_each = var.set_objects

  triggers = {
    cluster_instance_ids = each.value.a
  }
}
