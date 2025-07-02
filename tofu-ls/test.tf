terraform {
  required_version = "~> 1.0"
  required_providers {
    signoz = {
      source  = "signoz/signoz"
      version = "1.11.4"
    }
  }
}
