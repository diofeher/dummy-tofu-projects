# foo/terragrunt.hcl
inputs = {
  content = "Hello from dev, Terragrunt!"
  output_dir = get_terragrunt_dir()
}

# foo/terragrunt.hcl
terraform {
  source = "../shared"
}

