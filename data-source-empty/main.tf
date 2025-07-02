data "aws_subnets" "example" {
  filter {
    name   = "vpc-id"
    values = ["123"]
  }
}
