
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.0.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "6.9.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.3"
    }
  }
}
