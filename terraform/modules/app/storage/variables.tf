# Syntax Global Variables

variable "prefix" {
  description = "Syntax Infrastructure Prefix"
  default = "st"
}

variable "owner" {
  type = string
  description = "Owner Tag Value"
}

variable "project" {
  type = string
  description = "Project Tag Value"
}

variable "region" {
  type = string
  description = "AWS Default Region"
  default = "eu-west-1"
}

variable "vpc_id" {
  type = string
  description = "AWS VPC ID"
}

variable "default_profile" {
  type = string
  description = "AWS CLI Default Profile"
  default = "terraform-ml-prod"
}

variable "stage" {
  type = string
  description = "Project Stage (project or ongoing)"
  default = "project"
}

variable "cl_ir_ml_hackathon_app_prod_frontend_bucket_name" {
  type = string
  description = "CxLink Hackathon Emergencies Production App Frontend S3 Bucket"
}

variable "cl_ir_ml_hackathon_app_dev_frontend_bucket_name" {
  type = string
  description = "CxLink Hackathon Emergencies Development Env App Frontend S3 Bucket"
}

variable "cl_ir_s3_kms_key_id" {
  type = string
  description = "CxLink S3 KMS Custom Key ID"
}

