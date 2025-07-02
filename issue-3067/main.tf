module "foo" {
  source = "./foo"
  count  = 2
  stuff  = "s"
}

output "output" {
  value = length(module.foo)
}
