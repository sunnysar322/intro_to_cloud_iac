# config

put in your own backend.tfvars files here

format is:

```terraform 
bucket         = "cigna-tf-state-{ACCOUNT_NUMBER_HERE}"
key            = "tecdp-training-2024-test/dev.tfstate"
region         = "us-east-1"
dynamodb_table = "cigna-tf-lock-{ACCOUNT_NUMBER_HERE}"
profile        = "default"
```

you can also create a variables.tfvars file and pass in any vairbales you might want to be environment specific.
