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

variable "cl_ir_ml_hackathon_empathy_aws_iam_read_only_user_name" {
  type = string
  description = "CxLink Hackathon AWS Auditor IAM User Name"
}

variable "cl_ir_ml_hackathon_empathy_aws_iam_read_only_user_policy_name" {
  type = string
  description = "CxLink Hackathon AWS Auditor IAM User Policy Name"
}

