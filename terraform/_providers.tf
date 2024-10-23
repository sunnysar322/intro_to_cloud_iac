terraform {
  required_version = ">= 1.3.0, < 2.0.0"
  required_providers {
    aws = {
      version = ">= 4.0, < 6.0.0"
    }
  }
  backend "s3" {}
}

provider "aws" {
  region  = "us-east-1"
  profile = "my-test-account"

  default_tags {
    tags = {
      "AssetOwner"       = "sunny.sarker@evernorth.com"
      "Environment" = "Demo"
      # CostCenter       = 
      # ServiceNowBA     = 
      # ServiceNowAS     = 
      # SecurityReviewID = "RITM4540869"
    }
  }
}
