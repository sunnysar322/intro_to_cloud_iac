import json
import boto3
import os
import uuid

dynamodb = boto3.resource('dynamodb')

def handler(event, context):
    table = dynamodb.Table(os.environ['DYNAMODB_TABLE'])

    # Handle POST request to add item to DynamoDB
    if event['httpMethod'] == 'POST':
        body = json.loads(event['body'])
        item = {
            'id': str(uuid.uuid4()),  # Generate a unique ID for the item
            'name': body['name'],     # Extract 'name' from the request body
            'email': body['email']    # Extract 'email' from the request body
        }

        table.put_item(Item=item)

        return {
            'statusCode': 200,
            'body': json.dumps({'message': 'Item added', 'item': item})
        }

    return {
        'statusCode': 400,
        'body': json.dumps({'message': 'Unsupported method'})
    }
