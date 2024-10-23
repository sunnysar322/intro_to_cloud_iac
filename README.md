# Introduction to Cloud - IaC Demo

This demo will be aimed for beginners to AWS development to deploy their first serverless application into AWS using terraform.

## Instructions
### Prerequisites

- Install Terraform
- Have an AWS Account ready to use (personal or A Cloud Guru Sandbox recommended)

### Configuring your AWS profile

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

Here are the commands

```tf
terraform init
```

This first command will initalize terraform in your folder.

```tf
terraform plan
```

This second command will generate a plan file that will comapre your existing infrasctuctrure in your account to whats being created. 

```tf
terraform apply
```

This last command will apply all of your changes in the plan as long as it is not stale or created too long ago. 

### Cleanup

Run this command in the folder to destroy all your resrouces:

```tf
terraform destroy
```
