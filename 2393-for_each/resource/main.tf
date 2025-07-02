variable "aws_regions" {
  type = map(object({
    vpc_cidr_block = string
  }))

  default = {
    us-east-1 = {
        vpc_cidr_block = "10.1.0.0/16"
    }
    sa-east-1 = {
        vpc_cidr_block = "10.2.0.0/16"
    }
  }
}

provider "aws" {
  alias    = "by_region"
  for_each = var.aws_regions

  region = each.key
}

resource "aws_cloudwatch_log_group" "lambda_cloudfront" {                             
  for_each = var.aws_regions
  provider = aws.by_region[each.key]
  name              = "/aws/lambda/${each.value.vpc_cidr_block}.lambda"
  retention_in_days = 60
}
