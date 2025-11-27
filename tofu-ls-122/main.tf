terraform { 
    required_providers {
      aws = {
          source  = "hashicorp/aws"
          version = "~> 6.22.1" # Example version constraint
        }
    }
}

resource "terraform_data" "example" {
  input = "Hello, World!"
}

ephemeral "aws_secretsmanager_secret_version" "db_password" {
  secret_id = aws_secretsmanager_secret_version.db_password.secret_id

  lifecycle {
    enabled1 = false
    enabled = true
  }
}

resource "terraform_data" "example" {
  input = "Hello, World!"
  input2 = "test"
}

data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "hashicorp"
    workspaces = {
      name = "vpc-prod"
    }
  }
  config1 = {


    
    organization = "hashicorp"
    workspaces = {
      name = "vpc-prod"
    }
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "example"
  bucket1 = "asdsad"
}