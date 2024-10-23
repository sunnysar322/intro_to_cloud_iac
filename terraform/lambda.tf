resource "aws_lambda_function" "lambda1" {
  filename         = data.archive_file.lambda1_zip.output_path
  function_name    = "${local.prefix}-LambdaFunction1"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "main.handler"
  source_code_hash = data.archive_file.lambda1_zip.output_base64sha256
  runtime          = "python3.9"
  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.my_table.name
      S3_BUCKET      = aws_s3_bucket.bucket.id
    }
  }
}

resource "aws_lambda_function" "lambda2" {
  filename         = data.archive_file.lambda2_zip.output_path
  function_name    = "${local.prefix}-LambdaFunction2"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "main.handler"
  source_code_hash = data.archive_file.lambda2_zip.output_base64sha256
  runtime          = "python3.9"
  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.my_table.name
      S3_BUCKET      = aws_s3_bucket.bucket.id
    }
  }
}
