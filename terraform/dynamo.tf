# Create a DynamoDB table
resource "aws_dynamodb_table" "hello_world_table" {
  name         = "${local.prefix}-hello-world-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S" # 'S' stands for String type
  }
  point_in_time_recovery {
    enabled = true
  }
}

# create the table item
resource "aws_dynamodb_table_item" "hello_world_item" {

  table_name = aws_dynamodb_table.hello_world_table.name
  hash_key   = aws_dynamodb_table.hello_world_table.hash_key

  item = <<ITEM
{
  "id": { "S": "1" },
  "name": { "S": "Sunny Sarker" },
  "email": { "S": "sunny.sarker@helloworld.com" }
}
ITEM
}