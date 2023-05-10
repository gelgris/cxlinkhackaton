terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
      configuration_aliases = [
              aws.account-742189430206-eu-south-2
       ]
    }
  }
}
