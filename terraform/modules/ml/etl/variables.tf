# Syntax Global Variables

variable "prefix" {
  type = string
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

variable "cl_ir_ml_hackathon_ea_use_case" {
  type = string
  description = "CxLink Hackathon Empathy Use Case"
  default = "retail_sales"
}

# KMS Values

variable "cl_ir_lambda_kms_key_id" {
  type = string
  description = "Syntax Lambda Encryption Custom KMS Key"
}

variable "cl_ir_ecr_kms_key_id" {
  type = string
  description = "Syntax ECR Image Encryption Custom KMS Key"
}

variable "cl_ir_cloudwatch_kms_key_id" {
  type = string
  description = "Syntax CloudWatch Logs Encryption Custom KMS Key"
}

variable "cl_ir_s3_kms_key_id" {
  type = string
  description = "Syntax S3 Encryption Custom KMS Key"
}

variable "cl_ir_glue_kms_key_id" {
  type = string
  description = "Syntax Glue Encryption Custom KMS Key"
}

# Glue Trigger

variable "cl_ir_ml_hackathon_ea_glue_job_trigger_name" {
  type = string
  description = "CxLink Hackathon Empathy Transformation Glue Job Trigger Name"
}

variable "cl_ir_ml_hackathon_ea_glue_job_trigger_enabled" {
  type = bool
  description = "Whether If CxLink Hackathon Empathy Transformation Glue Job Trigger is enabled or not"
}

variable "cl_ir_ml_hackathon_ea_glue_job_trigger_type" {
  type = string
  description = "CxLink Hackathon Empathy Transformation Glue Job Trigger Type"
}

variable "cl_ir_ml_hackathon_ea_glue_job_trigger_scheduling" {
  type = string
  description = "CxLink Hackathon Empathy Transformation Glue Job Trigger Scheduling Expression"
}

variable "cl_ir_ml_hackathon_ea_glue_job_trigger_timeout" {
  type = number
  description = "CxLink Hackathon Empathy Transformation Glue Job Trigger Timeout"
}

variable "cl_ir_ml_hackathon_ea_glue_job_trigger_delay" {
  type = number
  description = "CxLink Hackathon Empathy Transformation Glue Job Trigger Delay. Number of minutes to wait before sending a job run delay notification"
}

# Glue Job

variable "cl_ir_ml_hackathon_ea_glue_job_role_name" {
  type = string
  description = "CxLink Hackathon Empathy Glue Job IAM Role Name"
}

variable "cl_ir_ml_hackathon_ea_glue_bucket_name" {
  type = string
  description = "CxLink Hackathon Empathy Glue Scripts S3 Bucket Name"
}

variable "cl_ir_ml_hackathon_ea_glue_job_role_policy_name" {
  type = string
  description = "CxLink Hackathon Empathy Glue Job IAM Policy Name"
}

variable "cl_ir_ml_hackathon_ea_glue_job_name" {
  type = string
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job Name"
}

variable "cl_ir_ml_hackathon_ea_glue_job_description" {
  type = string
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job Default Arguments"
}

variable "cl_ir_ml_hackathon_ea_glue_job_connections" {
  type = list
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job Connections"
}

variable "cl_ir_ml_hackathon_ea_glue_job_non_overridable_arguments" {
  type = map
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job Non Overridable Arguments"
}

variable "cl_ir_ml_hackathon_ea_glue_job_glue_version" {
  type = string
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job Glue Version"
}

variable "cl_ir_ml_hackathon_ea_glue_job_timeout" {
  type = number
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job Timeout"
}

variable "cl_ir_ml_hackathon_ea_glue_job_number_of_workers" {
  type = number
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job Number of Workers"
}

variable "cl_ir_ml_hackathon_ea_glue_job_worker_type" {
  type = string
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job Worker Type"
}

variable "cl_ir_ml_hackathon_ea_glue_job_max_capacity" {
  type = string
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job Max Capacity"
}

variable "cl_ir_ml_hackathon_ea_glue_job_max_retries" {
  type = number
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job Max Retries"
}

variable "cl_ir_ml_hackathon_ea_glue_job_command_name" {
  type = string
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job Command Name (glueetl, pythonshell, gluestreamingo)"
}

variable "cl_ir_ml_hackathon_ea_glue_job_command_python_version" {
  type = string
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job Python Version"
}

variable "cl_ir_ml_hackathon_ea_glue_job_language" {
  type = string
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job Language (python or scala)"
}

variable "cl_ir_ml_hackathon_ea_glue_job_tempdir" {
  type = string
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job Tempdir"
}

variable "cl_ir_ml_hackathon_ea_glue_job_use_postgres_driver" {
  type = string
  description = "Whether If CxLink Hackathon Empathy DataSets Normalization Glue Job will use Postgres Driver or not with preference over Redshift one (Only on Glue v2.0)"
  default = "true"
}

variable "cl_ir_ml_hackathon_ea_glue_job_python_mods_install_options" {
  type = string
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job Additional Python Modules Install Options"
}

variable "cl_ir_ml_hackathon_ea_glue_job_disable_proxy" {
  type = string
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job Disable Proxy"
}

variable "cl_ir_ml_hackathon_ea_glue_job_python_modules" {
  type = string
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job Python Additional Modules"
}

variable "cl_ir_ml_hackathon_ea_glue_job_enable_autoscaling" {
  type = string
  description = "Whether If CxLink Hackathon Empathy DataSets Normalization Glue Job Autoscaling is Enabled or Not"
}

variable "cl_ir_ml_hackathon_ea_glue_job_enable_metrics" {
  type = string
  description = "Whether If CxLink Hackathon Empathy DataSets Normalization Glue Job Metrics are Enabled or Not"
}

variable "cl_ir_ml_hackathon_ea_glue_job_enable_spark_ui" {
  type = string
  description = "Whether If CxLink Hackathon Empathy DataSets Normalization Glue Job Spark UI is Enabled or Not"
}

variable "cl_ir_ml_hackathon_ea_glue_job_spark_event_logs" {
  type = string
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job Spark Events"
}

variable "cl_ir_ml_hackathon_ea_glue_job_enable_job_insights" {
  type = string
  description = "Whether If CxLink Hackathon Empathy DataSets Normalization Glue Job Insights are Enabled or Not"
}

variable "cl_ir_ml_hackathon_ea_glue_job_enable_datacatalog" {
  type = string
  description = "Whether If CxLink Hackathon Empathy DataSets Normalization Glue Job DataCatalog is Enabled or Not"
}

variable "cl_ir_ml_hackathon_ea_glue_job_bookmark_option" {
  type = string
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job Behaviour Option"
}

variable "cl_ir_ml_hackathon_ea_glue_job_extra_files" {
  type = string
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job Extra Files"
}

variable "cl_ir_ml_hackathon_ea_glue_job_datalake_formats" {
  type = string
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job DataLake Formats Used (hudi,delta,iceberg)"
}

variable "cl_ir_ml_hackathon_ea_glue_job_enable_continuous_cloudwatch_log" {
  type = string
  description = "Whether If CxLink Hackathon Empathy DataSets Normalization Glue Job Continuous CloudWatch Log is Enabled or Not"
}

variable "cl_ir_ml_hackathon_ea_glue_job_log_group_name" {
  type = string
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job Log Group Name"
}

variable "cl_ir_ml_hackathon_ea_glue_job_log_group_retention" {
  type = number
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job Log Group Retention in days"
}

variable "cl_ir_ml_hackathon_ea_glue_job_output_format" {
  type = string
  description = "CxLink Hackathon Empathy DataSets Normalization Glue Job Output Format"
}

# DataLake S3 Buckets Values

variable "cl_ir_ml_hackathon_datalake_account_id" {
  type = string
  description = "Syntax Raw Submissions DataLake AWS Account ID"
}

variable "cl_ir_ml_hackathon_ea_raw_bucket_name" {
  type = string
  description = "Syntax Raw Submissions DataLake S3 Bucket Name"
}

variable "cl_ir_ml_hackathon_ea_curated_bucket_name" {
  type = string
  description = "Syntax curated Submissions DataLake S3 Bucket Name"
}

# Glue Values

variable "cl_ir_ml_hackathon_ea_etl_glue_security_config_name" {
  type = string
  description = "CxLink Hackathon Empathy Glue Security Configuration Name"
}

variable "cl_ir_ml_hackathon_ea_etl_glue_security_config_cloudwatch_encryption" {
  type = string
  description = "Whether If CxLink Hackathon Empathy Glue Security Configuration Cloudwatch Encryption is Enabled or Not (DISABLED or SSE-KMS)"
}

variable "cl_ir_ml_hackathon_ea_etl_glue_security_config_job_bookmarks_encryption" {
  type = string
  description = "Whether If CxLink Hackathon Empathy Glue Security Configuration Job Bookmarks Encryption is Enabled or Not (DISABLED or CSE-KMS)"
}

variable "cl_ir_ml_hackathon_ea_glue_crawler_role_name" {
  type = string
  description = "CxLink Hackathon Empathy Glue Crawler IAM Role Name"
}

variable "cl_ir_ml_hackathon_ea_glue_crawler_role_policy_name" {
  type = string
  description = "CxLink Hackathon Empathy Glue Crawler IAM Policy Name"
}

variable "cl_ir_ml_hackathon_ea_glue_database_name" {
  type = string
  description = "CxLink Hackathon Empathy Glue Catalog Database Name"
}

variable "cl_ir_ml_hackathon_ea_glue_table_name" {
  type = string
  description = "CxLink Hackathon Empathy Glue Catalog Table Name"
}

variable "cl_ir_ml_hackathon_ea_etl_glue_crawler_name" {
  type = string
  description = "CxLink Hackathon Empathy Glue Crawler Name"
}

variable "cl_ir_ml_hackathon_ea_etl_glue_crawler_schedule" {
  type = string
  description = "CxLink Hackathon Empathy ETL Crawler Scheduling"
}

variable "cl_ir_ml_hackathon_ea_etl_glue_crawler_deletes_schema_change_policy" {
  type = string
  description = "CxLink Hackathon Empathy ETL Crawler Policy for Deletes Schema Changes (LOG, DELETE_FROM_DATABASE, DEPRECATE_IN_DATABASE)"
}

variable "cl_ir_ml_hackathon_ea_etl_glue_crawler_updates_schema_change_policy" {
  type = string
  description = "CxLink Hackathon Empathy ETL Crawler Policy for Updates Schema Changes (LOG, DELETE_FROM_DATABASE, DEPRECATE_IN_DATABASE)"
}

variable "cl_ir_ml_hackathon_ea_etl_glue_crawler_lineage_configuration" {
  type = string
  description = "Specifies If the CxLink Hackathon Empathy ETL Crawler Lineage is Enabled or Not (ENABLED or DISABLED)"
}

variable "cl_ir_ml_hackathon_ea_etl_glue_crawler_recrawl_policy" {
  type = string
  description = "CxLink Hackathon Empathy ETL Crawler (CRAWL_EVENT_MODE, CRAWL_EVERYTHING, CRAWL_NEW_FOLDERS_ONLY)"
}

variable "cl_ir_ml_hackathon_ea_etl_glue_crawler_exclusions" {
  type = list
  description = "CxLink Hackathon Empathy ETL Crawler S3 Exclusions"
}

# CxLink Raw Submissions DataLake S3 Bucket Values

variable "cl_ir_ml_hackathon_aws_forecast_raw_bucket_name" {
  type = string
  description = "CxLink Hackathon Empathy BI Raw Bucket Name"
}

# CxLink Curated DataLake S3 Bucket Values

variable "cl_ir_ml_hackathon_aws_forecast_curated_bucket_name" {
  type = string
  description = "CxLink Hackathon Empathy BI Curated Bucket Name"
}
