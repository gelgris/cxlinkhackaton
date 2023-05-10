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

variable "customer_id" {
  type = string
  description = "CxLink AWS Hackathon Customer Id"
  default = "cruz-roja"
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

variable "private_subnet_ids" {
  type = list
  description = "CxLink AWS Hackathon Private Subnets IDs"
}

variable "cl_ir_ml_cl_sample_use_case" {
  type = string
  description = "CxLink AWS Hackathon for Good Use Case"
  default = "work_force"
}

# KMS Values

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

variable "cl_ir_lambda_kms_key_id" {
  type = string
  description = "CxLink Lambda Encryption Custom KMS Key"
}

variable "cl_ir_glue_kms_key_id" {
  type = string
  description = "CxLink Glue Encryption Custom KMS Key"
}

variable "cl_ir_lambda_kms_key_alias" {
  type = string
  description = "CxLink Lambda Encryption Custom KMS Key"
}

variable "cl_ir_glue_kms_key_alias" {
  type = string
  description = "CxLink Glue Encryption Custom KMS Key"
}

variable "cl_ir_ecr_kms_key_alias" {
  type = string
  description = "CxLink ECR Image Encryption Custom KMS Key"
}

variable "cl_ir_cloudwatch_kms_key_alias" {
  type = string
  description = "CxLink CloudWatch Logs Encryption Custom KMS Key"
}

variable "cl_ir_s3_kms_key_alias" {
  type = string
  description = "CxLink S3 Encryption Custom KMS Key"
}

# S3 Values

variable "cl_ir_ml_hackathon_aws_forecast_raw_bucket_name" {
  type = string
  description = "CxLink Raw Submissions DataLake S3 Bucket Name"
}

variable "cl_ir_ml_hackathon_aws_forecast_curated_bucket_name" {
  type = string
  description = "CxLink Curated DataLake S3 Bucket Name"
}

variable "cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_name" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps Pipeline Artifacts S3 Bucket Name"
}

variable "cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_lifecycle_archive_rule_name" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps Pipeline Artifacts S3 Bucket Lifecycle Rule Name"
}

variable "cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_lifecycle_glacier_rule_filter_key" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps Pipeline Artifacts S3 Bucket Lifecycle Rule Filter Key"
}

variable "cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_lifecycle_glacier_rule_filter_value" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps Pipeline Artifacts S3 Bucket Lifecycle Rule Filter Value"
}

variable "cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_lifecycle_archive_rule_glacier_days" {
  type = number
  description = "CxLink AWS Hackathon for Good MLOps Pipeline Artifacts S3 Bucket Lifecycle Rule Deep Glacier IR Days Retention"
}

variable "cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_lifecycle_archive_rule_deep_days" {
  type = number
  description = "CxLink AWS Hackathon for Good MLOps Pipeline Artifacts S3 Bucket Lifecycle Rule Deep Glacier Days Retention"
}

# Pipeline Values

variable "cl_ir_ml_hackathon_mlops_pipeline_role_name" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps Pipeline IAM Role Name"
}

variable "cl_ir_ml_hackathon_mlops_pipeline_role_policy_name" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps Pipeline IAM Role Policy Name"
}

variable "cl_ir_ml_hackathon_mlops_pipeline_codebuild_role_name" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps Pipeline CodeBuild IAM Role Name"
}

variable "cl_ir_ml_hackathon_mlops_pipeline_codebuild_role_policy_name" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps Pipeline CodeBuild IAM Role Policy Name"
}

variable "cl_ir_ml_hackathon_mlops_pipeline_repo_name" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps Pipeline CodeCommit Repo Name"
}

variable "cl_ir_ml_hackathon_mlops_pipeline_repo_approval_rule_name" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps Pipeline CodeCommit Repo Sources Approval Rule" 
}

variable "cl_ir_ml_hackathon_mlops_pipeline_repo_approvers_arn" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps Pipeline CodeCommit Repo Sources ARN or ARN pattern for the IAM User/Role/Group etc that can be used for approving Pull Requests"
}

variable "cl_ir_ml_hackathon_mlops_pipeline_github_repo_name" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps Pipeline Github Repo Name"
}

variable "cl_ir_ml_hackathon_mlops_pipeline_github_connection_name" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps Pipeline CSV Repository Star Connection Name"
}

variable "cl_ir_ml_hackathon_mlops_pipeline_name" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps Pipeline Name"
}

variable "cl_ir_ml_hackathon_mlops_pipeline_repo_id" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps Pipeline CSV Repository Id"
}

variable "cl_ir_ml_hackathon_mlops_pipeline_branch" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps Pipeline CSV Repo Branch"
}

variable "cl_ir_ml_hackathon_mlops_project_name" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps Project Name"
}

# CodeBuild Values

variable "cl_ir_ml_hackathon_mlops_log_group_retention" {
  type = number
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild LogGroup Retention"
}

variable "cl_ir_ml_hackathon_mlops_codebuild_compute_type" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Projects Compute Type"
}

variable "cl_ir_ml_hackathon_mlops_codebuild_image" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Projects Image"
}

variable "cl_ir_ml_hackathon_mlops_codebuild_type" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Projects Type"
}

variable "cl_ir_ml_hackathon_mlops_codebuild_concurrent_build_limit" {
  type = number
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Projects Concurrent Build Limit"
}

variable "cl_ir_ml_hackathon_mlops_codebuild_queued_timeout" {
  type = number
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Projects Queued Timeout"
}

variable "cl_ir_ml_hackathon_mlops_codebuild_privileged_mode_enabled" {
  type = bool
  description = "Whther If the CxLink AWS Hackathon for Good MLOps CodeBuild Docker Privileged Mode is Enabled or Not"
}

# CxLink AWS Hackathon for Good MLOps CodeBuild Projects Global Values

variable "cl_ir_ml_hackathon_mlops_codebuild_security_group_name" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Security Group Name"
}

variable "cl_ir_ml_hackathon_mlops_api_secret_value" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps API Access Key Secret"
}

# CxLink AWS Hackathon for Good MLOps CodeBuild Data Preprocessing Project Values

variable "cl_ir_ml_hackathon_mlops_data_preprocessing_name" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Data Preprocessing Project Name"
}

variable "cl_ir_ml_hackathon_mlops_data_preprocessing_description" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Data Preprocessing Project Description"
}

variable "cl_ir_ml_hackathon_mlops_data_preprocessing_build_timeout" {
  type = number
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Data Preprocessing Project Build Timeout"
}


variable "cl_ir_ml_hackathon_mlops_data_preprocessing_branch" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Data Preprocessing Project Branch Name"
}

variable "cl_ir_ml_hackathon_mlops_data_preprocessing_buildspec" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Data Preprocessing Project Buildspec"
}

# CxLink AWS Hackathon for Good MLOps CodeBuild Import Project Values

variable "cl_ir_ml_hackathon_mlops_import_name" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Import Project Name"
}

variable "cl_ir_ml_hackathon_mlops_import_description" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Import Project Description"
}

variable "cl_ir_ml_hackathon_mlops_import_build_timeout" {
  type = number
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Import Project Build Timeout"
}

variable "cl_ir_ml_hackathon_mlops_import_branch" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Import Project Branch Name"
}

variable "cl_ir_ml_hackathon_mlops_import_buildspec" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Import Project Buildspec"
}

variable "cl_ir_ml_hackathon_mlops_horizont" {
  type = number
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Forecast Horizont"
}

variable "cl_ir_ml_hackathon_mlops_import_test_mode" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Import Project Forecast Test Mode Enabled"
}

variable "cl_ir_ml_hackathon_mlops_dataset_format" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Import Project Forecast DataSet Format"
}

variable "cl_ir_ml_hackathon_mlops_target_dataset_filename" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Forecast Target DataSet Filename"
}

variable "cl_ir_ml_hackathon_mlops_related_dataset_filename" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Forecast Related DataSet Filename"
}

variable "cl_ir_ml_hackathon_mlops_timestamp_format" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Forecast Timestamp Format"
}


variable "cl_ir_ml_hackathon_mlops_dataset_group_name" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Forecast DataSet Group Name"
}

variable "cl_ir_ml_hackathon_mlops_import_wait_time" {
  type = number
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Import Project Forecast Import Wait Time"
}

variable "cl_ir_ml_hackathon_mlops_model_deploy_wait_time" {
  type = number
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Import Project Forecast Model Deploy Wait Time"
}

variable "cl_ir_ml_hackathon_mlops_import_mode" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Import Project Forecast Import Mode"
}

# CxLink AWS Hackathon for Good MLOps CodeBuild Training Project Values

variable "cl_ir_ml_hackathon_mlops_training_name" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Training Project Name"
}

variable "cl_ir_ml_hackathon_mlops_training_test_mode" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Train Project Forecast Test Mode Enabled"
}

variable "cl_ir_ml_hackathon_mlops_training_description" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Training Project Description"
}

variable "cl_ir_ml_hackathon_mlops_training_build_timeout" {
  type = number
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Training Project Build Timeout"
}

variable "cl_ir_ml_hackathon_mlops_training_branch" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Training Project Branch Name"
}

variable "cl_ir_ml_hackathon_mlops_training_buildspec" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Training Project Buildspec"
}

variable "cl_ir_ml_hackathon_mlops_forecast_frecuency" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Training Project Forecast Frecuency"
}

variable "cl_ir_ml_hackathon_mlops_forecast_predictor_creation_wait_time" {
  type = number
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Training Project Forecast "
}

variable "cl_ir_ml_hackathon_mlops_forecast_monitor_creation_wait_time" {
  type = number
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Training Project Forecast Monitor Creation Wait Time"
}

variable "cl_ir_ml_hackathon_mlops_forecast_forecast_creation_wait_time" {
  type = number
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Training Project Forecast Creation Wait Time"
}

# CxLink AWS Hackathon for Good MLOps CodeBuild Evaluation Project Values

variable "cl_ir_ml_hackathon_mlops_evaluation_name" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Evaluation Project Name"
}

variable "cl_ir_ml_hackathon_mlops_evaluation_description" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Evaluation Project Description"
}

variable "cl_ir_ml_hackathon_mlops_evaluation_build_timeout" {
  type = number
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Evaluation Project Build Timeout"
}

variable "cl_ir_ml_hackathon_mlops_evaluation_branch" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Evaluation Project Branch Name"
}

variable "cl_ir_ml_hackathon_mlops_evaluation_buildspec" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Evaluation Project Buildspec"
}

# CxLink AWS Hackathon for Good MLOps CodeBuild Model Deploy Project Values

variable "cl_ir_ml_hackathon_mlops_model_deploy_name" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Model Deploy Project Name"
}

variable "cl_ir_ml_hackathon_mlops_model_deploy_description" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Model Deploy Project Description"
}

variable "cl_ir_ml_hackathon_mlops_model_deploy_build_timeout" {
  type = number
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Model Deploy Project Build Timeout"
}


variable "cl_ir_ml_hackathon_mlops_model_deploy_branch" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Model Deploy Project Branch Name"
}

variable "cl_ir_ml_hackathon_mlops_model_deploy_buildspec" {
  type = string
  description = "CxLink AWS Hackathon for Good MLOps CodeBuild Model Deploy Project Buildspec"
}


