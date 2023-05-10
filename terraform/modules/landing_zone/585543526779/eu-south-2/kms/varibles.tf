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

variable "cl_ir_sqs_kms_key_alias_name" {
  type = string
  description = "CxLink Ireland Landing Zone sqs Buckets Encryption Custom KMS Key Alias Name"
}

variable "cl_ir_sqs_kms_key_description" {
  type = string
  description = "CxLink Ireland Landing Zone sqs Buckets Encryption Custom KMS Key Description"
}

variable "cl_ir_sqs_kms_key_retention" {
  type = number
  description = "CxLink Ireland Landing Zone sqs Buckets Encryption Custom KMS Key Retention before Deletion (in days)"
}

variable "cl_ir_efs_kms_key_alias_name" {
  type = string
  description = "CxLink Ireland Landing Zone efs Buckets Encryption Custom KMS Key Alias Name"
}

variable "cl_ir_efs_kms_key_description" {
  type = string
  description = "CxLink Ireland Landing Zone efs Buckets Encryption Custom KMS Key Description"
}

variable "cl_ir_efs_kms_key_retention" {
  type = number
  description = "CxLink Ireland Landing Zone efs Buckets Encryption Custom KMS Key Retention before Deletion (in days)"
}

variable "cl_ir_sagemaker_kms_key_alias_name" {
  type = string
  description = "CxLink Ireland Landing Zone sagemaker Buckets Encryption Custom KMS Key Alias Name"
}

variable "cl_ir_sagemaker_kms_key_description" {
  type = string
  description = "CxLink Ireland Landing Zone sagemaker Buckets Encryption Custom KMS Key Description"
}

variable "cl_ir_sagemaker_kms_key_retention" {
  type = number
  description = "CxLink Ireland Landing Zone sagemaker Buckets Encryption Custom KMS Key Retention before Deletion (in days)"
}

variable "cl_ir_ebs_kms_key_alias_name" {
  type = string
  description = "CxLink Ireland Landing Zone ebs Buckets Encryption Custom KMS Key Alias Name"
}

variable "cl_ir_ebs_kms_key_description" {
  type = string
  description = "CxLink Ireland Landing Zone ebs Buckets Encryption Custom KMS Key Description"
}

variable "cl_ir_ebs_kms_key_retention" {
  type = number
  description = "CxLink Ireland Landing Zone ebs Buckets Encryption Custom KMS Key Retention before Deletion (in days)"
}

variable "cl_ir_rds_kms_key_alias_name" {
  type = string
  description = "CxLink Ireland Landing Zone rds Buckets Encryption Custom KMS Key Alias Name"
}

variable "cl_ir_rds_kms_key_description" {
  type = string
  description = "CxLink Ireland Landing Zone rds Buckets Encryption Custom KMS Key Description"
}

variable "cl_ir_rds_kms_key_retention" {
  type = number
  description = "CxLink Ireland Landing Zone rds Buckets Encryption Custom KMS Key Retention before Deletion (in days)"
}

variable "cl_ir_glue_kms_key_alias_name" {
  type = string
  description = "CxLink Ireland Landing Zone glue Buckets Encryption Custom KMS Key Alias Name"
}

variable "cl_ir_glue_kms_key_description" {
  type = string
  description = "CxLink Ireland Landing Zone glue Buckets Encryption Custom KMS Key Description"
}

variable "cl_ir_glue_kms_key_retention" {
  type = number
  description = "CxLink Ireland Landing Zone glue Buckets Encryption Custom KMS Key Retention before Deletion (in days)"
}

variable "cl_ir_s3_kms_key_alias_name" {
  type = string
  description = "CxLink Ireland Landing Zone S3 Buckets Encryption Custom KMS Key Alias Name"
}

variable "cl_ir_s3_kms_key_description" {
  type = string
  description = "CxLink Ireland Landing Zone S3 Buckets Encryption Custom KMS Key Description"
}

variable "cl_ir_s3_kms_key_retention" {
  type = number
  description = "CxLink Ireland Landing Zone S3 Buckets Encryption Custom KMS Key Retention before Deletion (in days)"
}

variable "cl_ir_ecr_kms_key_alias_name" {
  type = string
  description = "CxLink Ireland Landing Zone ecr Buckets Encryption Custom KMS Key Alias Name"
}

variable "cl_ir_ecr_kms_key_description" {
  type = string
  description = "CxLink Ireland Landing Zone ecr Buckets Encryption Custom KMS Key Description"
}

variable "cl_ir_ecr_kms_key_retention" {
  type = number
  description = "CxLink Ireland Landing Zone ecr Buckets Encryption Custom KMS Key Retention before Deletion (in days)"
}

variable "cl_ir_lambda_kms_key_alias_name" {
  type = string
  description = "CxLink Ireland Landing Zone lambda Buckets Encryption Custom KMS Key Alias Name"
}

variable "cl_ir_lambda_kms_key_description" {
  type = string
  description = "CxLink Ireland Landing Zone lambda Buckets Encryption Custom KMS Key Description"
}

variable "cl_ir_lambda_kms_key_retention" {
  type = number
  description = "CxLink Ireland Landing Zone lambda Buckets Encryption Custom KMS Key Retention before Deletion (in days)"
}

variable "cl_ir_cloudwatch_kms_key_alias_name" {
  type = string
  description = "CxLink Ireland Landing Zone cloudwatch Buckets Encryption Custom KMS Key Alias Name"
}

variable "cl_ir_cloudwatch_kms_key_description" {
  type = string
  description = "CxLink Ireland Landing Zone cloudwatch Buckets Encryption Custom KMS Key Description"
}

variable "cl_ir_cloudwatch_kms_key_retention" {
  type = number
  description = "CxLink Ireland Landing Zone cloudwatch Buckets Encryption Custom KMS Key Retention before Deletion (in days)"
}
