import json
import boto3
import os

dynamodb = boto3.resource('dynamodb')

def handler(event, context):
    table = dynamodb.Table(os.environ['DYNAMODB_TABLE'])

    # Read from DynamoDB
    response = table.get_item(
        Key={
            'id': event['pathParameters']['id']
        }
    )
    item = response.get('Item', {})

    return {
        'statusCode': 200,
        'body': json.dumps(item)
    }
