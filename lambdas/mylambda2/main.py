import json

def handler(event, context):
    # Assuming the payload is sent in JSON format
    body = json.loads(event['body']) if 'body' in event else {}

    return {
        'statusCode': 200,
        'body': json.dumps({
            'message': 'Hello from Lambda 2!',
            'method': 'POST',
            'received_payload': body
        })
    }
