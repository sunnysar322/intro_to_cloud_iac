# Introduction to Cloud - IaC Demo

This demo will be aimed for beginners to AWS development to deploy their first serverless application into AWS using terraform.

## Background

### Introduction
We are going to build a basic serverless application in AWS using DynamoDB, Lambda, API gateway, and S3 static site hosting. This will be a simple "Hello-World" app where the string is stored in DynamoDB. Once a GET request is made to the API, Lambda will be triggered and run a DynamoDB query to retrieve the "Hello-World" String and return it back to the user. 

However, it’s not that simple, we also need to create a role for lambda to use with the correct permissions to access both dynamo and API gateway. We will also setup the DynamoDB table with an item as well as setup all the portions of the API gateway including the stage and deployment. And lastly we will need to create the S3 bucket, add the correct bucket policy and insert the website files.

The architecture will look like the following:

![arch_diagram](images/intro_iac.drawio.png) 

### Resources to Build
This Terraform module creates the following resources:

- A [DynamoDB table](terraform/dynamodb.tf) named `"{project_name}-email-table"`.
- Two [Lambda functions](terraform/lambda.tf) named `"{project_name}-Lambda1"` and `"{project_name}-Lambda2"` that queries the DynamoDB table to read or write. They wil be associated with different API requests for GET and POST
- An [IAM role](terraform/role.tf) for the Lambda function with the necessary permissions to access DynamoDB.
- An [API Gateway REST API](terraform/api_gateway.tf) named `"{project_name}-my-api"` with a resource and method for the "/hello" endpoint.
- An [S3 bucket](terraform/s3.tf) with the correct policies and static site hosting enabled.

## Instructions
### Prerequisites

- Install [Terraform](https://developer.hashicorp.com/terraform/install)
- Have an AWS Account ready to use (personal or A Cloud Guru Sandbox recommended for static site hosting)
  - Install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
  - If you have an account ready to use, have used saml2aws before, and have it set up, you can use that instead as well by setting profile in the next step to either `saml` or `default` depending on how you set it up with `saml2aws configure` or `aws configure`

Confrim you have both by running `terraform --version` and `aws --version`

### Configuring your AWS profile

Feel free to ignore this step if you have a account to use and either aws cli or saml2aws set up.

```sh
aws configure --profile my-test-account
```

When prompted pass in the following:

- AWS Access Key ID: Your personal account access key ID.
- AWS Secret Access Key: Your personal account secret access key.
- Default region: Choose the region you want to use (e.g., us-east-1).
- Default output format: Choose json or text, as per your preference.

To verify you can check your `~/.aws/credentials` file in your terminal.

*Note: if using a acloud guru account these accounts will shut down in a few hours so will need to re run this command if needed*

### Running terraform
In order to deploy this applicaiton. You need to first go into the terraform directory then run the terraform workflow.

Here are the commands:

```tf
cd terraform

terraform init
```

This first command will initalize terraform in your folder.

```tf
terraform plan --out tfplan
```

This second command will generate a plan file that will comapre your existing infrasctuctrure in your account to whats being created. 

```tf
terraform apply tfplan
```

This last command will apply all of your changes in the plan as long as it is not stale or created too long ago. 

### Cleanup


After you are done testing, make sure to clean up your terraform resources by running the destroy command:

```shell
terraform destroy
```

Make sure your are in the terraform directory and have the aws profile configured (or saml2aws logged in) in order for this to work. 

## Additional Resources

### AWS
- [AWS CLI Documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)
- [AWS Services Documentation](https://docs.aws.amazon.com/)
- [IAM Permissions Reference](https://aws.permissions.cloud/iam/)
- [IAM Users, Role & Groups Getting Started](https://dev.to/aws-builders/a-beginners-guide-to-aws-identity-and-access-management-iam-4j5c)

### Terraform
- [Intro to Terraform](https://developer.hashicorp.com/terraform/intro)
- [Terraform CLI Docs](https://developer.hashicorp.com/terraform/cli)
- [AWS Examples](https://developer.hashicorp.com/terraform/tutorials/aws-get-started)

### Serverless/Microservices
- [Intro to serverless](https://cloud.google.com/discover/what-is-serverless-architecture)
- [Intro to Microservices](https://medium.com/microservicegeeks/an-introduction-to-microservices-a3a7e2297ee0)

### DevOps & CI/CD
- [DevOps & CI/CD Intro](https://www.redhat.com/en/topics/devops/what-is-ci-cd)
- [Github Actions](https://docs.github.com/en/actions)  
