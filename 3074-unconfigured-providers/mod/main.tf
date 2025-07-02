terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      configuration_aliases = [aws.this]
    }
  }
}

output "this" {
  value = provider::aws::arn_build("test", "test", "test", "test", "1")
}
