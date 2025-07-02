resource "terraform_data" "example" {
  for_each = toset(split(",", sensitive("a,b,c")))
}
