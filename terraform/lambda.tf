# Create Lambda 1
resource "aws_lambda_function" "lambda1" {
  function_name    = "${local.prefix}-LambdaFunction1"
  runtime          = "python3.9"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "lambda_function.lambda_handler"
  filename         = data.archive_file.lambda1_zip.output_path
  source_code_hash = data.archive_file.lambda1_zip.output_base64sha256
}

# Create Lambda 2
resource "aws_lambda_function" "lambda2" {
  function_name    = "${local.prefix}-LambdaFunction2"
  runtime          = "python3.9"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "lambda_function.lambda_handler"
  filename         = data.archive_file.lambda2_zip.output_path
  source_code_hash = data.archive_file.lambda2_zip.output_base64sha256

}
