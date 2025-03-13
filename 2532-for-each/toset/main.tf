resource "null_resource" "a" {
  # for_each = toset(["one"])
  for_each = toset([])
  # for_each = toset([null])
}
