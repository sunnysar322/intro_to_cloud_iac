resource "aws_cloudwatch_log_group" "lambda1_logs" {
  name              = "/aws/lambda/${local.prefix}-LambdaFunction1"
  retention_in_days = 14
}

resource "aws_lambda_function" "lambda1" {
  filename         = data.archive_file.lambda1_zip.output_path
  function_name    = "${local.prefix}-LambdaFunction1"
  role             = aws_iam_role.lambda_role.arn
  handler          = "main.handler"
  source_code_hash = data.archive_file.lambda1_zip.output_base64sha256
  runtime          = "python3.9"
  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.hello_world_table.name
      S3_BUCKET      = aws_s3_bucket.bucket.id
    }
  }
  depends_on = [aws_cloudwatch_log_group.lambda1_logs]
}

resource "aws_lambda_permission" "api_gateway_invoke" {
  statement_id  = "AllowApiGatewayInvokeLambda1"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda1.function_name
  principal     = "apigateway.amazonaws.com"
}


### Resources for lambda 2 which is for POST

resource "aws_cloudwatch_log_group" "lambda2_logs" {
  name              = "/aws/lambda/${local.prefix}-LambdaFunction2"
  retention_in_days = 14
}

resource "aws_lambda_function" "lambda2" {
  filename         = data.archive_file.lambda2_zip.output_path
  function_name    = "${local.prefix}-LambdaFunction2"
  role             = aws_iam_role.lambda_role.arn
  handler          = "main.handler"
  source_code_hash = data.archive_file.lambda2_zip.output_base64sha256
  runtime          = "python3.9"
  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.hello_world_table.name
      S3_BUCKET      = aws_s3_bucket.bucket.id
    }
  }
  depends_on = [aws_cloudwatch_log_group.lambda2_logs]
}

resource "aws_lambda_permission" "api_gateway_invoke2" {
  statement_id  = "AllowApiGatewayInvokeLambda2"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda2.function_name
  principal     = "apigateway.amazonaws.com"
}