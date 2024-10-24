import json
import boto3
import os
import uuid

dynamodb = boto3.resource('dynamodb')

def handler(event, context):
    table = dynamodb.Table(os.environ['DYNAMODB_TABLE'])
    
    # Parse the incoming JSON body
    try:
        body = json.loads(event['body'])
    except:
        return {
            'statusCode': 400,
            'body': json.dumps('Invalid JSON body')
        }
    
    # Generate a unique ID for the item
    item_id = str(uuid.uuid4())
    
    # Prepare the item to be inserted
    item = {
        'id': item_id,
        **body  # This unpacks all fields from the body into the item
    }
    
    # Write to DynamoDB
    try:
        table.put_item(Item=item)
        return {
            'statusCode': 200,
            'body': json.dumps({
                'message': 'Item added successfully!',
                'id': item_id
            })
        }
    except Exception as e:
        print(e)  # Log the error
        return {
            'statusCode': 500,
            'body': json.dumps('Error adding item to the database')
        }
