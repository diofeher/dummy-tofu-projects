# foo/terragrunt.hcl
inputs = {
  content = "Dev content: ${dependency.dev.outputs.content}"
  output_dir = get_terragrunt_dir()
  input_2 = local.test3
  input_3 = local.test3
}

locals {
  test3 = "identifier"
}

# foo/terragrunt.hcl
terraform {
  source = "../shared"
}

dependency "dev" {
  config_path = var.test2
  mock_outputs = {
    content = "Mocked content from dev"
  }
}

