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

variable "cl_awseservedSSO_administratorAccess_role" {
  type = string
  description = "AWS SSO Reserved Administrators Team Access IAM Role Name"
}

variable "cl_awseservedSSO_security_team_role" {
  type = string
  description = "AWS SSO ReservedSecurity Team Access IAM Role Name"
}

# CxLink Hackathon AWS DataSets

variable "cl_ir_ml_hackathon_aws_forecast_customers" {
  description = "A map of all CxLink Hackathon Customers"
  type        = map(any)
  default     = {}
}

variable "cl_ir_ml_hackathon_aws_forecast_customers_files" {
  type = set(string)
  description = "A set of all CxLink Hackathon Customers Files"
  default     = []
}

variable "cl_ir_ml_hackathon_aws_forecast_target_datasets" {
  description = "A map of all CxLink Hackathon Target DataSets"
  type        = map(any)
  default     = {}
}

variable "cl_ir_ml_hackathon_aws_forecast_target_datasets_files" {
  type = set(string)
  description = "A set of all CxLink Hackathon Target DataSets Files"
  default     = []
}

variable "cl_ir_ml_hackathon_aws_forecast_related_datasets" {
  description = "A map of all CxLink Hackathon Related DataSets"
  type        = map(any)
  default     = {}
}

variable "cl_ir_ml_hackathon_aws_forecast_related_datasets_files" {
  type = set(string)
  description = "A set of all CxLink Hackathon Related DataSets Files"
  default     = []
}

variable "cl_ir_ml_hackathon_aws_forecast_use_case" {
  type = string
  description = "CxLink Hackathon Use Case"
  default = "work_force"
}

variable "cl_ir_ml_hackathon_aws_forecast_role_name" {
  type = string
  description = "CxLink hackathon DataSets IAM Role Name"
}


variable "cl_ir_ml_hackathon_aws_forecast_role_policy_name" {
  type = string
  description = "CxLink hackathon DataSets IAM Policy Name"
}

variable "cl_ir_ml_hackathon_aws_forecast_work_force_dataset_timezone" {
  type = string
  description = "CxLink hackathon Work Force DataSet Timezone"
}

variable "cl_ir_ml_hackathon_aws_forecast_work_force_dataset_geolocation" {
  type = string
  description = "CxLink hackathon  Work Force DataSet Geolocation"
}

variable "cl_ir_ml_hackathon_aws_forecast_work_force_dataset_use_geolocation" {
  type = string
  description = "Whther If CxLink hackathon  Work Force DataSet will use Geolocation or Not"
}

variable "cl_ir_ml_hackathon_aws_forecast_work_force_dataset_format" {
  type = string
  description = "CxLink hackathon  Work Force DataSet Format (CSV or PARQUET)"
}

variable "cl_ir_ml_hackathon_aws_forecast_work_force_dataset_group_name" {
  type = string
  description = "CxLink hackathon  Work Force DataSet Group Name"
  default = ""
}

variable "cl_ir_ml_hackathon_aws_forecast_work_force_dataset_target_name" {
  type = string
  description = "CxLink hackathon  Work Force Target DataSet Name"
  default = ""
}

variable "cl_ir_ml_hackathon_aws_forecast_work_force_dataset_domain" {
  type = string
  description = "CxLink hackathon  Work Force DataSet Domain"
  default = ""
}

variable "cl_ir_ml_hackathon_aws_forecast_work_force_dataset_target_type" {
  type = string
  description = "CxLink hackathon  Work Force Target DataSet Type. "
  default = ""
}

variable "cl_ir_ml_hackathon_aws_forecast_work_force_dataset_target_frecuency" {
  type = string
  description = "CxLink hackathon  Work Force Target DataSet Frecuency"
  default = ""
}

variable "cl_ir_ml_hackathon_aws_forecast_work_force_dataset_item_metadata_name" {
  type = string
  description = "CxLink hackathon Work Force Item Metadata DataSet Name"
  default = ""
}

variable "cl_ir_ml_hackathon_aws_forecast_work_force_dataset_item_metadata_type" {
  type = string
  description = "CxLink hackathon Work Force Item Metadata DataSet Type. "
  default = ""
}

variable "cl_ir_ml_hackathon_aws_forecast_work_force_dataset_item_metadata_frecuency" {
  type = string
  description = "CxLink hackathon Work Force Item Metadata DataSet Frecuency"
  default = ""
}

variable "cl_ir_ml_hackathon_aws_forecast_work_force_dataset_related_name" {
  type = string
  description = "CxLink hackathon Work Force Related DataSet Name"
  default = ""
}

variable "cl_ir_ml_hackathon_aws_forecast_work_force_dataset_related_type" {
  type = string
  description = "CxLink hackathon Work Force Related DataSet Type. "
  default = ""
}

variable "cl_ir_ml_hackathon_aws_forecast_work_force_dataset_related_frecuency" {
  type = string
  description = "CxLink hackathon Work Force Related DataSet Frecuency"
  default = ""
}

# CxLink Raw Submissions DataLake S3 Bucket Values

variable "cl_ir_ml_hackathon_filter_lambda_aws_forecast_raw_bucket_notification_filter_prefix" {
  type = string
  description = "Filter Prefix for the Objects that will trigger the Notification"
}

variable "cl_ir_ml_hackathon_filter_lambda_aws_forecast_raw_bucket_notification_filter_suffix" {
  type = string
  description = "Filter Suffix for the Objects that will trigger the Notification"
}

variable "cl_ir_ml_hackathon_aws_forecast_raw_bucket_notification_filter_prefix" {
  type = string
  description = "Filter Prefix for the Objects that will trigger the Notifcation"
}

variable "cl_ir_ml_hackathon_aws_forecast_raw_bucket_notification_filter_suffix" {
  type = string
  description = "Filter Suffix for the Objects that will trigger the Notifcation"
}

variable "cl_ir_ml_hackathon_audio_lambda_aws_forecast_raw_bucket_notification_filter_prefix" {
  type = string
  description = "Filter Prefix for the Objects that will trigger the Notification"
}

variable "cl_ir_ml_hackathon_audio_lambda_aws_forecast_raw_bucket_notification_filter_suffix" {
  type = string
  description = "Filter Suffix for the Objects that will trigger the Notification"
}

variable "cl_ir_ml_hackathon_text_lambda_aws_forecast_raw_bucket_notification_filter_prefix" {
  type = string
  description = "Filter Prefix for the Objects that will trigger the Notification"
}

variable "cl_ir_ml_hackathon_text_lambda_aws_forecast_raw_bucket_notification_filter_suffix" {
  type = string
  description = "Filter Suffix for the Objects that will trigger the Notification"
}

variable "cl_ir_ml_hackathon_aws_forecast_raw_bucket_lifecycle_archive_rule_name" {
  type = string
  description = "CxLink Raw Submissions DataLake S3 Bucket Lifecycle Rule Name"
}

variable "cl_ir_ml_hackathon_aws_forecast_raw_bucket_lifecycle_glacier_rule_filter_key" {
  type = string
  description = "CxLink Raw Submissions DataLake S3 Bucket Lifecycle Rule Filter Key"
}

variable "cl_ir_ml_hackathon_aws_forecast_raw_bucket_lifecycle_glacier_rule_filter_value" {
  type = string
  description = "CxLink Raw Submissions DataLake S3 Bucket Lifecycle Rule Filter Value"
}

variable "cl_ir_ml_hackathon_aws_forecast_raw_bucket_lifecycle_archive_rule_glacier_days" {
  type = string
  description = "CxLink Raw Submissions DataLake S3 Bucket Lifecycle Rule Glacier IR in Days"
}


variable "cl_ir_ml_hackathon_aws_forecast_raw_bucket_lifecycle_archive_rule_deep_days" {
  type = string
  description = "CxLink Raw Submissions DataLake S3 Bucket Lifecycle Rule Deep Glacer in Days"
}

# CxLink Curated DataLake S3 Bucket Values

variable "cl_ir_ml_hackathon_aws_forecast_curated_bucket_lifecycle_archive_rule_name" {
  type = string
  description = "CxLink Curated DataLake S3 Bucket Lifecycle Rule Name"
}

variable "cl_ir_ml_hackathon_aws_forecast_curated_bucket_lifecycle_glacier_rule_filter_key" {
  type = string
  description = "CxLink Curated DataLake S3 Bucket Lifecycle Rule Filter Key"
}

variable "cl_ir_ml_hackathon_aws_forecast_curated_bucket_lifecycle_glacier_rule_filter_value" {
  type = string
  description = "CxLink Curated DataLake S3 Bucket Lifecycle Rule Filter Value"
}

variable "cl_ir_ml_hackathon_aws_forecast_curated_bucket_lifecycle_archive_rule_glacier_days" {
  type = string
  description = "CxLink Curated DataLake S3 Bucket Lifecycle Rule Glacier IR in Days"
}

variable "cl_ir_ml_hackathon_aws_forecast_curated_bucket_lifecycle_archive_rule_deep_days" {
  type = string
  description = "CxLink Curated DataLake S3 Bucket Lifecycle Rule Deep Glacer in Days"
}

variable "cl_ir_hackathon_empathy_extract_lambda_function_name" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Extract Lambda Function Name"
}

variable "cl_ir_hackathon_empathy_filter_lambda_function_name" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Filter Lambda Function Name"
}

variable "cl_ir_hackathon_empathy_text_lambda_function_name" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Text Lambda Function Name"
}


variable "cl_ir_hackathon_empathy_audio_lambda_function_name" {
  type = string
  description = "CxLink Hackathon Empathy Assitant Audio Lambda Function Name"
}


#  CxLink Hackathon QueryForecast Secret Manager

variable "cl_ir_ml_hackathon_aws_forecast_api_secret_name" {
  type = string
  description = "CxLink Hackathon Credientials Secret Manager Secret Name"
}

variable "cl_ir_ml_hackathon_aws_forecast_api_secret_value" {
  type = string
  description = "CxLink Hackathon Credientials Secret Manager Secret Value"
  default = ""
}

# KMS Values

variable "cl_ir_lambda_kms_key_id" {
  type = string
  description = "CxLink Lambda Encryption Custom KMS Key"
}

variable "cl_ir_ecr_kms_key_id" {
  type = string
  description = "CxLink ECR Image Encryption Custom KMS Key"
}

variable "cl_ir_cloudwatch_kms_key_id" {
  type = string
  description = "CxLink CloudWatch Logs Encryption Custom KMS Key"
}

variable "cl_ir_s3_kms_key_id" {
  type = string
  description = "CxLink S3 Encryption Custom KMS Key"
}




