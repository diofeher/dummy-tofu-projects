resource "null_resource" "a" {
}

resource "null_resource" "c" {
  for_each = tomap({
    "a" = null_resource.a.id
  })
}
