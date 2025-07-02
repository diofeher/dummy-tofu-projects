# foo/terragrunt.hcl
inputs = {
  content = "Hello from foo, Terragrunt!"
}

# foo/terragrunt.hcl
terraform {
  source = "../shared"
}
