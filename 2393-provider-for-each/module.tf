#### MODULESSSSSS

variable "regions" {
  description = "A list of regions that should have a deployment."
  type        = set(string)
  default     = ["us-east-1", "sa-east-1"]
}
variable "disabled_regions" {
  description = "A list of regions that should be disabled and all resources removed."
  type        = set(string)
  default     = ["sa-east-1"]
}

provider "aws" {
  alias    = "by_region"
  for_each = var.regions
  region = each.value
}

# module "mod" {
#   source   = "./mod"
#   providers = {
#     aws = aws.by_region[each.value]
#   }
#   // Here we make sure that all resources from a region are removed
#   // if the region is disabled. This must be done before removing
#   // a region entirely.
#   for_each = setsubtract(var.regions, var.disabled_regions)
# }


#### RESOURCES 
resource "aws_cloudwatch_log_group" "lambda_cloudfront" {
  name     = "/aws/lambda/${each.key}.lambda"
  for_each = setsubtract(var.regions, var.disabled_regions)
  provider = aws.by_region[each.key]
}

# Resource 2 - providers on `provider`
# resource "aws_cloudwatch_log_group" "lambda_cloudfront" {                             
#   name = "/aws/lambda/${each.value}.lambda"                                     
#   retention_in_days = 60
#   for_each = local.aws_regions
# }

# Modules with provider for_each
# module "mod" {
#   source   = "./mod"
#   for_each = local.aws_regions
# }
