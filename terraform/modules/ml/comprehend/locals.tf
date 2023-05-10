locals {

  environment = {
    dev   = "dev"
    pre   = "pre"
    prod  = "prod"
    test  = "test"
  }

  tags = {
    environment         = local.environment[terraform.workspace]
    project             = var.project
    owner               = var.owner
    stage               = var.stage
  }
}


