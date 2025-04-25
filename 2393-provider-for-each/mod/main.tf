
resource "aws_cloudwatch_log_group" "lambda_cloudfront" {
  name     = "/aws/lambda/test.lambda"
}
