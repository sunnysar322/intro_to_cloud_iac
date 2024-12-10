# Terraform 

This directory contains Terraform configurations to deploy and manage an AWS infrastructure that includes API Gateway, Lambda functions, S3, and DynamoDB. The setup is designed to handle HTTP requests (GET and POST) at an /items endpoint with proper Cross-Origin Resource Sharing (CORS) support.

## Main Terraform Files

- `api_gateway.tf`:
    - Configures the API Gateway REST API, including the /items resource, HTTP methods (GET, POST, OPTIONS), and CORS integration.

- `dynamo.tf`:
    - Provisions a DynamoDB table for storing data accessed via the Lambda functions.

- `lambda.tf`:
    - Defines the Lambda functions and their configurations.
    - References lambda_function1 and lambda_function2 for code deployment.

- `s3.tf`:
    - Provisions an S3 bucket for hosting static assets or storing data.

- `role.tf`:
    - Configures IAM roles and policies for the Lambda functions to access necessary AWS resources.

- `_providers.tf`:
    - Specifies the AWS provider and related settings.

- `_locals.tf`:
    - Declares local variables for reuse across configurations.

- `_data.tf`:
    - Retrieves metadata about the AWS account and region for dynamic configurations.

## Supporting Files

- `lambda_function1.zip` and `lambda_function2.zip`:
    - Zipped Lambda function code. Ensure these files are updated with the latest application logic.

- `terraform.tfstate` and `terraform.tfstate.backup`:
    - Tracks the state of the deployed resources. Do not edit these files manually.

- `tfplan`:
    - Represents the most recent execution plan. Use this to review changes before applying.

- `.terraform` and `.terraform.lock.hcl`:
    - Terraform provider and dependency management files.