resource "aws_api_gateway_rest_api" "my_api" {
  name        = "MyApi"
  description = "API Gateway for managing items"
}

resource "aws_api_gateway_resource" "items" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "items"
}

resource "aws_api_gateway_method" "get_items" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.items.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "post_items" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.items.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_items_integration" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.items.id
  http_method             = aws_api_gateway_method.get_items.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda1.invoke_arn
}

resource "aws_api_gateway_integration" "post_items_integration" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.items.id
  http_method             = aws_api_gateway_method.post_items.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda2.invoke_arn
}

resource "aws_api_gateway_deployment" "myapi_deployment" {
  depends_on = [
    aws_api_gateway_integration.get_items_integration,
    aws_api_gateway_integration.post_items_integration
  ]
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  stage_name  = "prod"
}