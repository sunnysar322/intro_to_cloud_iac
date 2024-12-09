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

![terraform init](images/terraform_init.PNG)

```tf
terraform plan --out tfplan
```

This second command will generate a plan file that will comapre your existing infrasctuctrure in your account to whats being created. 

![terraform plan](images/terraform_plan.PNG)

```tf
terraform apply tfplan
```

This last command will apply all of your changes in the plan as long as it is not stale or created too long ago. 

![terraform apply](images/terraform_apply.PNG)

### Testing the application

After terraform plan is run, your application is now up and running in your AWS account. If you navigate to the AWS console you can now see your resrouces in Lambda, Dynamo, S3 and API gateway. 

#### Opening the Webpage 

At the end of your `terraform apply` command, one of the specified outputs should have been the website URL for the deployed application. In our case it is `http://demo-sunny-bucket.s3-website-us-east-1.amazonaws.com/`

The site should look like the following:

![post](images/website_post.PNG)

If you add a name to the email list, you should see an output at the bottom showing a unique ID for that entry in Dynamo DB.

#### DynamoDB

To verify the information is in DynamoDB you can either search that email in the below section or check Dynamo DB yourself. If you navigate to the AWS console, go to dynamo db, open tables, click on your table name, and explore table items, you should see the new entry. 

![db](images/dynamoDB_after_post.PNG)

This shows that the request went successfully to the API gateway endpoint from the front end and triggered the lambda function to write the data into DynamoDB. 

#### Other Resources

If you want to verify all of your other resources were built correctly here is what each console screen should look like

##### API Gateway

![api](images/api_gateway.PNG)

In this we have our main `/items` route with GET, POST, and OPTIONS enabled. We also need an additonal `{id}` path at the end of items with a GET method to support the POST requests. 

OPTIONS enables Cross origin resource sharing (CORS) so that requests from different domains such as our static site can be handled and accepted. 

##### Lambda

![lambda](images/lambda_list.PNG)

And if you look at the code in each lambda, you will see the code from the `lambdas` folder in this directory have all be uploaded. 

![code](images/lambda_code.PNG)

##### S3
![s3](images/s3_bucket.PNG)

This is where all our front end code is hosted and if you go into settings you can see the configurations for static site hosting. 


### Cleanup

After you are done testing, make sure to clean up your terraform resources by running the destroy command:

```shell
terraform destroy
```
You will first be prompted to say yes if you want to delete the resources with a list of resources that will be deleted. 

![terraform destroy](images/terraform_destroy1.PNG)

After this the destroy may run for a few minutes then show the following:

![terraform destroy2](images/terraform_destroy2.PNG)

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
