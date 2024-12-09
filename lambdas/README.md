# Lambdas

Although the lambdas themselves are made in terraform, we store the code to the lambda functions in this folder. Lambda1 is for the GET request and Lambda 2 is for the POST request. 

In our environment varibales, we pass in `DYNAMO_TABLE` which contains the db table name which the lambda function will query. The lambdas permissions to query this table are already set in terraform with its role, however we do need to include headers in our response for API Gateway. 

# Lambdas Folder

This folder contains the source code and deployment packages for the Lambda functions used in the project. These Lambda functions handle the back-end logic for the API Gateway and perform operations such as adding and retrieving items.


## Folder Contents

### Files
1. **`lambda_function1.zip`**:
   - A zipped archive of the first Lambda function's source code.
   - Handles retrieving items (`GET /items`) based on the provided query parameter (`email`).

2. **`lambda_function2.zip`**:
   - A zipped archive of the second Lambda function's source code.
   - Handles adding new items (`POST /items`) by processing the request body and interacting with the DynamoDB table.

3. The lambda1 and lambda2 folder
    - The source python code for the zip files that are uploaded via terraform to the respective lambdas. 


## Lambda Functions Overview

### 1. `GET /items` - Retrieve Items
- **Lambda Function**: `LambdaFunction1`
- **Purpose**:
  - Processes incoming `GET` requests from the API Gateway.
  - Searches the DynamoDB table for items matching the provided query parameter (`email`).
- **CORS Headers**:
  - Includes `Access-Control-Allow-Origin`, `Access-Control-Allow-Methods`, and `Access-Control-Allow-Headers` in the response to enable browser compatibility.
- **Example Response**:
  ```json
  {
    "statusCode": 200,
    "body": {
      "items": [
        {
          "name": "Sunny Sarker",
          "email": "Sunny.Sarker@gmail.com"
        }
      ]
    }
  }

### 1. `POST /items` - Add New Items

- **Lambda Function**: `LambdaFunction2`
- **Purpose**:
  - Processes incoming `POST` requests from the API Gateway.
  - Extracts `name` and `email` from the request body.
  - Adds the data to a DynamoDB table.
- **CORS Headers**:
  - Includes `Access-Control-Allow-Origin`, `Access-Control-Allow-Methods`, and `Access-Control-Allow-Headers` in the response to enable browser compatibility.
- **Example Response**:
  ```json
  {
    "statusCode": 200,
    "body": {
      "message": "Item added successfully",
      "item": {
        "name": "Sunny Sarker",
        "email": "sunny.sarker@gmail.com"
      }
    }
  }
