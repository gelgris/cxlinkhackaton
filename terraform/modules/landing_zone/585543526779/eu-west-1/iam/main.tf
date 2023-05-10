locals {
  environment = {
    dev   = "dev"
    pre   = "pre"
    prod  = "prod"
    test  = "test"
  }

  tags = {
    environment		= local.environment[terraform.workspace]
    project		= var.project
    owner		= var.owner
  }
}

data "aws_caller_identity" "current" {
  provider = aws.account-585543526779-eu-west-1
}

