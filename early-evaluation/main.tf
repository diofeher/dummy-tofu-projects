variable "module_name" {
  type    = string
  default = "s3_bucket"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

module "sample_bucket" {
  source = "./modules/${var.module_name}"
}
