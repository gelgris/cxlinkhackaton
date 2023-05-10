terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
      configuration_aliases = [
              aws.account-585543526779-eu-west-1,
              aws.account-742189430206-eu-west-1
       ]
    }
  }
}
