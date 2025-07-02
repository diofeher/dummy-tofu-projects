variable "my_complex_variable" {
  type = object({
    name        = string
    description = string
    tags        = map(string)
  })
}


output "my_complex_variable" {
  value = var.my_complex_variable.name
}
