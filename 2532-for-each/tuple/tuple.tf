resource "null_resource" "a" {
  for_each = ["a", "b", "c"]
}
