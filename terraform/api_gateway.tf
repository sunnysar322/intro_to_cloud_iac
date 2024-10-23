# API Gateway REST API
resource "aws_api_gateway_rest_api" "myapi" {
  name = "${local.prefix}-MyAPI"

}

# API Gateway Resource for Lambda1 (GET request)
resource "aws_api_gateway_resource" "lambda1_resource" {
  rest_api_id = aws_api_gateway_rest_api.myapi.id
  parent_id   = aws_api_gateway_rest_api.myapi.root_resource_id
  path_part   = "lambda1"

}

# API Gateway Resource for Lambda2 (POST request)
resource "aws_api_gateway_resource" "lambda2_resource" {
  rest_api_id = aws_api_gateway_rest_api.myapi.id
  parent_id   = aws_api_gateway_rest_api.myapi.root_resource_id
  path_part   = "lambda2"

}
