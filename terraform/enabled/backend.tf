terraform {
  backend "s3" {
    bucket = "cl-ir-ml-hackathon-infrastructure-tf-prod"
    key    = "ec2/terraform.tfstate"
    region = "eu-west-1"
    profile = "terraform-ht-ir-dev"
  }
}


