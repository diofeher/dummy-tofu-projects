resource "null_resource" "a" {
  for_each = tomap({
    a_group       = { "eastus" : 1 }
    another_group = { "westus2" : 2 }
  })
}

resource "null_resource" "b" {
  for_each = tomap({
    a_group       = 1
    another_group = 1
  })
}
