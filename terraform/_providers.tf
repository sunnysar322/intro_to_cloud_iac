# here we configure terraform and sewt the version as well as the version of the package. Here we also set profile and any default resource tags

terraform {
  required_version = ">= 1.3.0, < 2.0.0"
  required_providers {
    aws = {
      version = ">= 4.0, < 6.0.0"
    }
  }
  # COMMENT BACK IN IF USING CIGNA account or any other with a tfstate bucket
  # backend "s3" {}
}

provider "aws" {
  region  = "us-east-1"

  profile = "my-test-account"
  # COMMENT Above line out and lines beneath back in if using different profile/ saml2aws
  # profile = "default"

  default_tags {
    tags = {
      "AssetOwner"  = "sunny.sarker@evernorth.com"
      "Environment" = "Demo"
      # CostCenter       = 
      # ServiceNowBA     = 
      # ServiceNowAS     = 
      # SecurityReviewID = "RITM4540869"
    }
  }
}
