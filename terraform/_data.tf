data "archive_file" "lambda1_zip" {
  type        = "zip"
  source_file = "${path.module}/../lambdas/mylambda1/main.py" # Path to the Python file
  output_path = "${path.module}/lambda_function1.zip"      # Output zip file
}

data "archive_file" "lambda2_zip" {
  type        = "zip"
  source_file = "${path.module}/../lambdas/mylambda2/main.py"
  output_path = "${path.module}/lambda_function2.zip"
}