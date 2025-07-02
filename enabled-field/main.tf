variable "on" {
  type = bool
}

resource "local_file" "test" {
  filename = "${path.module}/test.txt"
  content  = "Hello world!"
  lifecycle {
    enabled = var.on
  }
}

output "result" {
  // This is in a 1-tuple just because OpenTofu treats a fully-null
  // root module output value as if it wasn't declared at all,
  // but we want to make sure we're actually testing the result
  // of this resource directly.
  value = one(local_file.test[*].content, "default")
}
