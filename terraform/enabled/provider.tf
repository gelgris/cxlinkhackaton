provider "aws" {
  region   = "eu-west-1"
  profile  = "terraform-ht-ir-${local.environment[terraform.workspace]}"
}

provider "aws" {
  region   = "eu-south-2"
  profile  = "terraform-ht-ir-${local.environment[terraform.workspace]}"
  alias    = "account-585543526779-eu-south-2"
}

provider "aws" {
  region   = "eu-west-1"
  profile  = "terraform-ht-ir-${local.environment[terraform.workspace]}"
  alias    = "account-585543526779-eu-west-1"
}

provider "aws" {
  region   = "us-east-1"
  profile  = "terraform-ht-ir-${local.environment[terraform.workspace]}"
  alias    = "account-585543526779-us-east-1"
}

provider "awscc" {
  region   = "eu-west-1"
  profile  = "terraform-ht-ir-${local.environment[terraform.workspace]}"
}

provider "aws" {
  region   = "eu-west-1"
  profile  = "terraform-ml-${local.environment[terraform.workspace]}"
  alias    = "account-742189430206-eu-west-1"
}

provider "aws" {
  region   = "eu-west-1"
  profile  = "terraform-ml-prod"
  alias    = "account-235641605167-eu-west-1"
}


provider "aws" {
  region   = "eu-south-2"
  profile  = "terraform-ml-${local.environment[terraform.workspace]}"
  alias    = "account-742189430206-eu-south-2"
}

