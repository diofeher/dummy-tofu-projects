terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    } 
  }
}

variable "aws_active_regions" {
  type = set(string)

  default = ["us-east-1", "sa-east-2"]
}

# variable "aws_disabled_regions" {
#   description = "A list of regions that should be disabled and all resources removed."
#   type        = set(string)
#   default     = []
# }

# provider "aws" {
#   alias    = "us_east_1"

#   region = "us-east-1"
# }

# provider "aws" {
#   alias    = "us_west_1"

#   region = "us-west-1"
# }

provider "aws" {
  alias    = "by_region"

  for_each = var.aws_active_regions
}
# resource "local_file" "root_local_file2" {
#   filename = "${path.module}/test.txt"
#   content  = "Hello world!"
#   for_each = var.aws_regions
#   provider = aws.by_region[each.key]
# }

resource "aws_cloudwatch_log_stream" "log" {
  log_group_name = "test"
  name = "test"

  provider = aws.by_region[each.key]
}

resource "aws_cloudwatch_log_stream" "log" {
  log_group_name = "test"
  name = "test"

  provider = aws.us_west_1
}



# resource "local_file" "root_local_file2" {
#   filename = "${path.module}/test.txt"
#   content = "test"
# }
# output "test" {
#   value = local_file.root_local_file2.content
# }
# resource "awscc_accessanalyzer_analyzer" "test" {
#   provider = aws.us_west_1
# }