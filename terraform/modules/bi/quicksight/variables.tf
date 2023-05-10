# CxLink Global Variables

variable "prefix" {
  type = string
  description = "CxLink Infrastructure Prefix"
  default = "cl"
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

variable "stage" {
  type = string
  description = "Project Stage (project or ongoing)"
  default = "project"
}

# KMS Values

variable "cl_ir_s3_kms_key_id" {
  type = string
  description = "CxLink S3 Encryption Custom KMS Key"
}

# Quicksight Values

variable "cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_admin_user_session_name" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight Cruz Roja Admin User Session Name"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_admin_user_email" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight Cruz Roja Admin User Email"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_admin_user_role" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight Cruz Roja Admin User Role (ADMIN, AUTHOR or READER)"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_admin_user_name" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight Cruz Roja Admin User Name"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_author_user_session_name" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight Cruz Roja Admin User Session Name"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_author_user_name" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight Author User Name"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_author_user_email" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight Author Author User Email"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_author_user_role" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight Author User Role (ADMIN, AUTHOR or READER)"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_group_name" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight Cruz Roja Group Name"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_group_description" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight Cruz Roja Group Description"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_account_name" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight Account Name"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_authentication_method" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight Authentication Method"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_edition" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight Edition"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_notification_email" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight Notification Mail"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_secret_name" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight User Password Secret Name"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_secret_password_length" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight User Password Length"
}

# Quicksight S3 DataSources

variable "cl_ir_ml_hackathon_empathy_quicksight_s3_datasource_name" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight DataSource Name"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_s3_datasource_description" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight DataSource Description"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_s3_datasource_username" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight DataSource User Name"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_s3_datasource_s3_manifest_key" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight DataSource S3 Manifest Key"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_s3_datasource_disable_ssl" {
  type = bool
  description = "Whether If the CxLink Hackathon Empathy Assitant Quicksight DataSource S3 SSL Support should be disabled or not"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_s3_datasource_type" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight DataSource Type"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_author_user_policy_name" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight S3 Admin User IAM Policy Name"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_admin_user_policy_name" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight S3 Admin User IAM Policy Name"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_role_name" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight Role Name"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_role_policy_name" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight IAM Role Policy"
}

# Quicksight Athena DataSources

variable "cl_ir_ml_hackathon_empathy_quicksight_athena_datasource_name" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight Athena DataSource Name"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_athena_datasource_description" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight Athena DataSource Description"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_athena_datasource_work_group" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight Athena DataSource Athena Work Group"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_athena_datasource_type" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight Athena DataSource Type"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_athena_datasource_username" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight Athena DataSource User Name"
}

# S3 DataLake Values

variable "cl_ir_ml_hackathon_empathy_quicksight_bucket_name" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight S3 Bucket Name"
}

variable "cl_ir_ml_hackathon_aws_forecast_curated_bucket_name" {
  type = string
  description = "CxLink Curated DataDataLake S3 Bucket Name"
}

variable "cl_ir_ml_hackathon_aws_forecast_raw_bucket_name" {
  type = string
  description = "CxLink Raw (Submissions) DataLake S3 Bucket Name"
}

# Athena Values

variable "cl_ir_ml_hackathon_empathy_quicksight_athena_wg_name" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Quicksight Athena DataSource Workgroup Name"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_athena_wg_enforcing_enabled" {
  type = bool
  description = "Whether If the CxLink Hackathon Empathy Assitant Quicksight Athena DataSource Workgroup Enforcing is enabled or not"
}

variable "cl_ir_ml_hackathon_empathy_quicksight_athena_wg_cloudwatch_metrics_enabled" {
  type = bool
  description = "Whether If the CxLink Hackathon Empathy Assitant Quicksight Athena DataSource Workgroup CloudWatch Metrics publish are enabled or not"
}


