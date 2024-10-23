provider "aws" {
  region  = "us-east-1"
  profile = "my-test-account"

default_tags {
    tags = {
      "Owner" = "sunny.sarker@evernorth.com"
      "Environment" = "Demo"
    }
  }
}
