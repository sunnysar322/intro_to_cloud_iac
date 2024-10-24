# Declare the API Gateway REST API
resource "aws_api_gateway_rest_api" "myapi" {
  name        = "${local.prefix}-MyAPI"
  description = "API Gateway for Lambda functions"
}

# API Gateway Resource for Lambda1 (GET request)
resource "aws_api_gateway_resource" "lambda1_resource" {
  rest_api_id = aws_api_gateway_rest_api.myapi.id
  parent_id   = aws_api_gateway_rest_api.myapi.root_resource_id
  path_part   = "lambda1"
}

resource "aws_api_gateway_method" "lambda1_method" {
  rest_api_id   = aws_api_gateway_rest_api.myapi.id
  resource_id   = aws_api_gateway_resource.lambda1_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda1_integration" {
  rest_api_id = aws_api_gateway_rest_api.myapi.id
  resource_id = aws_api_gateway_resource.lambda1_resource.id
  http_method = aws_api_gateway_method.lambda1_method.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda1.invoke_arn
}

# API Gateway Resource for Lambda2 (POST request)
resource "aws_api_gateway_resource" "lambda2_resource" {
  rest_api_id = aws_api_gateway_rest_api.myapi.id
  parent_id   = aws_api_gateway_rest_api.myapi.root_resource_id
  path_part   = "lambda2"
}

resource "aws_api_gateway_method" "lambda2_method" {
  rest_api_id   = aws_api_gateway_rest_api.myapi.id
  resource_id   = aws_api_gateway_resource.lambda2_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda2_integration" {
  rest_api_id = aws_api_gateway_rest_api.myapi.id
  resource_id = aws_api_gateway_resource.lambda2_resource.id
  http_method = aws_api_gateway_method.lambda2_method.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda2.invoke_arn
}

# Deploy the API Gateway
resource "aws_api_gateway_deployment" "myapi_deployment" {
  depends_on = [
    aws_api_gateway_integration.lambda1_integration,
    aws_api_gateway_integration.lambda2_integration
  ]
  rest_api_id = aws_api_gateway_rest_api.myapi.id
  stage_name  = "prod"
}
