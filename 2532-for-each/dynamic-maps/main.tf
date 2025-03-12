provider "aws" {
  region = "us-west-2"
}

# Define a variable for ingress rules
variable "ingress_rules" {
  description = "List of ingress rules"
  type        = map(string)
  default = {
    "a" : "0.0.0.0/0",
    "b" : "0.0.0.0/0",
  }
}

variable "egress_rules" {
  type = map(number)
  default = {
    "a" = 2,
    "c" = 2
  }
}

resource "aws_security_group" "example" {
  name        = "example_security_group"
  description = "Example security group"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = 80
      to_port     = 80
      protocol    = "HTTP"
      cidr_blocks = [ingress.value]
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "http"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
