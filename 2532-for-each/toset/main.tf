resource "null_resource" "a" {
  for_each = toset(["one", "two"])
}
