terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# Import block for random_id
import {
  to = random_id.example
  id = "YWJjZA"

  lifecycle {
    enabled = true
  }
}

# Resource definition
resource "random_id" "example" {
  byte_length = 4
}

