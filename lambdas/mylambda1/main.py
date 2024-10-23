import json

def handler(event, context):
    # Responding to GET requests
    return {
        'statusCode': 200,
        'body': json.dumps({
            'message': 'Hello from Lambda 1!',
            'method': 'GET',
            'input': event
        })
    }
