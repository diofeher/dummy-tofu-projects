# foo/terragrunt.hcl
inputs = {
  content = "Dev content: ${dependency.dev.outputs.content}"
  output_dir = get_terragrunt_dir()
}

# foo/terragrunt.hcl
terraform {
  source = "../shared"
}

dependency "dev" {
  config_path = "../dev"
  mock_outputs = {
    content = "Mocked content from dev"
  }
}
