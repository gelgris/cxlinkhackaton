# CxLink Global Variables

variable "prefix" {
  type = string
  description = "CxLink Infrastructure Prefix"
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

variable "cl_ir_ml_hackathon_aws_comprehend_role_name" {
  type = string
  description = "CxLink Hackathon Empathy Comprehend IAM Role Name"
}

variable "cl_ir_ml_hackathon_aws_comprehend_role_policy_name" {
  type = string
  description = "CxLink Hackathon Empathy Comprehend IAM Role Policy Name"
}

variable "cl_ir_ml_hackathon_aws_forecast_raw_bucket_name" {
  type = string
  description = "CxLink Hackathon Empathy DataLake Raw S3 Bucket Name"
}

variable "cl_ir_ml_hackathon_aws_forecast_curated_bucket_name" {
  type = string
  description = "CxLink Hackathon Empathy DataLake Curated S3 Bucket Name"
}

variable "cl_ir_s3_kms_key_id" {
  type = string
  description = "CxLink Hackathon Empathy S3 Encryption Custom KMS Key Id"
}

variable "cl_ir_comprehend_kms_key_id" {
  type = string
  description = "CxLink Hackathon Empathy Comprehend Encryption Custom KMS Key Id"
}

# Comprehend Values


variable "cl_ir_ml_hackathon_aws_comprehend_entity_recognizer_name" {
  type = string
  description = "CxLink Hackathon Empathy Comprehend Entity Recognizer Name"
}

variable "cl_ir_ml_hackathon_aws_comprehend_documents_key" {
  type = string
  description = "CxLink Hackathon Empathy Comprehend Entity Recognizer Documents S3 Key"
}

variable "cl_ir_ml_hackathon_aws_comprehend_entities_key" {
  type = string
  description = "CxLink Hackathon Empathy Comprehend Entity Recognizer Entities S3 Key"
}

