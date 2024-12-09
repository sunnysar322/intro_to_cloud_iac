import json
import boto3
import os
import uuid

dynamodb = boto3.resource('dynamodb')

def handler(event, context):
    table = dynamodb.Table(os.environ['DYNAMODB_TABLE'])

    try:
        # Parse the request body
        body = json.loads(event.get('body', '{}'))
        name = body.get('name')
        email = body.get('email')

        # Validate input
        if not name or not email:
            raise ValueError("Name and email are required")

        # Write to DynamoDB
        item_id = str(uuid.uuid4())
        item = {
            'id': item_id,
            'name': name,
            'email': email
        }
        table.put_item(Item=item)

        # Return success response
        return build_response(200, {'id': item_id})

    except ValueError as e:
        # Return a validation error
        return build_response(400, {'error': str(e)})

    except Exception as e:
        # Log the error and return an internal server error
        print(f"Error: {str(e)}")
        return build_response(500, {'error': 'Internal Server Error'})


def build_response(status_code, body):
    """Helper function to build a consistent response with CORS headers."""
    return {
        'statusCode': status_code,
        'headers': {
            'Access-Control-Allow-Credentials': 'true',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Headers': 'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token',
            'Access-Control-Allow-Methods': 'GET,OPTIONS,POST',
            'Content-Type': 'application/json'
        },
        'body': json.dumps(body)
    }
