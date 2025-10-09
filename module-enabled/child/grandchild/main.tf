resource "local_file" "a" {
  filename = "test.txt"
  content  = "test"

  # lifecycle {
  #   enabled = true
  # }
  # count = 1
}

variable "unrelated_field" {
  type = string
}

output "result" {
  value = "module is enabled"
}
