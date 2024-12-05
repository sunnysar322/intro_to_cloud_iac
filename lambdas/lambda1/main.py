import json
import boto3
import os

dynamodb = boto3.resource('dynamodb')

def handler(event, context):
    table = dynamodb.Table(os.environ['DYNAMODB_TABLE'])
    
    # Check if the request includes a query for email
    if event.get('queryStringParameters') and 'email' in event['queryStringParameters']:
        email = event['queryStringParameters']['email']
        response = table.scan(
            FilterExpression='email = :email',
            ExpressionAttributeValues={':email': email}
        )
        items = response.get('Items', [])
        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': 'GET,OPTIONS',
                'Access-Control-Allow-Headers': 'Content-Type'
            },
            'body': json.dumps(items)
        }

    # Default behavior: fetch item by ID
    if event.get('pathParameters') and 'id' in event['pathParameters']:
        response = table.get_item(
            Key={'id': event['pathParameters']['id']}
        )
        item = response.get('Item', {})
        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': 'GET,OPTIONS',
                'Access-Control-Allow-Headers': 'Content-Type'
            },
            'body': json.dumps(item)
        }

    return {
        'statusCode': 400,
        'headers': {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET,OPTIONS',
            'Access-Control-Allow-Headers': 'Content-Type'
        },
        'body': json.dumps({'error': 'Invalid request'})
    }
