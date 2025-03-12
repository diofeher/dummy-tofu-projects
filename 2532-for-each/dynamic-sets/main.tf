provider "aws" {
  region = "us-west-2"
}

# Define a variable for ingress rules
variable "ingress_rules" {
  description = "List of ingress rules"
  type = set(object({
    cidr     = string
    port     = number
    protocol = string
  }))
  default = [
    {
      cidr     = "0.0.0.0/0"
      port     = 80
      protocol = "tcp"
    },
    {
      cidr     = "0.0.0.0/0"
      port     = 443
      protocol = "tcp"
    }
  ]
}

variable "egress_rules" {
  type = set(number)
  default = [
    1,
  ]
}

resource "aws_security_group" "example" {
  name        = "example_security_group"
  description = "Example security group"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = [ingress.value.cidr]
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
