resource "null_resource" "a" {
  for_each = tomap({
    a_group       = "eastus"
    another_group = "westus2"
  })
}
