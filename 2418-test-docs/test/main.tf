
resource "local_file" "test2" {
  filename = "${path.module}/test.txt"
  content  = "Hello world!"
}
