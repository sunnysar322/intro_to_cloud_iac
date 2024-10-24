data "aws_caller_identity" "current" {}

locals {
  lambda1_zip_package = "${path.module}/lambda_function1.zip"
  lambda2_zip_package = "${path.module}/lambda_function2.zip"
}

data "archive_file" "lambda1_zip" {
  type        = "zip"
  source_dir  = "../lambdas/lambda1"
  output_path = local.lambda1_zip_package
}

data "archive_file" "lambda2_zip" {
  type        = "zip"
  source_dir  = "../lambdas/lambda2"
  output_path = local.lambda2_zip_package
}