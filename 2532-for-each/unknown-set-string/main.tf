

resource "null_resource" "a" {
}



resource "null_resource" "b" {
}

resource "null_resource" "c" {
  for_each = toset([null_resource.a.id, null_resource.b.id])
}
