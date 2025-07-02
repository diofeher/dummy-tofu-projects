variable "content" {}
variable "output_dir" {}

# foo/main.tf
resource "local_file" "file" {
  content  = var.content
  filename = "${var.output_dir}/hi.txt"
}
