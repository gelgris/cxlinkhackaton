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

variable "customer_id" {
  type = string
  description = "CxLink Hackathon Empathy Customer ID"
  default = "cruz-roja"
}

variable "vpc_id" {
  type = string
  description = "AWS VPC ID"
}

variable "default_profile" {
  type = string
  description = "AWS CLI Default Profile"
}

variable "stage" {
  type = string
  description = "Project Stage (project or ongoing)"
  default = "project"
}



# Forecast Customers

variable "cl_ir_ml_hackathon_forecast_customers" {
  description = "A map of all CxLink AWS Forecast Cutomers"
  type        = map(any)
  default     = {}
}

variable "cl_ir_ml_hackathon_forecast_customers_files" {
  type = set(string)
  description = "A set of all CxLink AWS Forecast Customers Files"
  default     = []
}

variable "cl_ir_ml_hackathon_forecast_dataset_s3_buckets" {
  description = "A map of all CxLink AWS Forecast S3 Buckets"
  type        = map(any)
  default     = {}
}

variable "cl_ir_ml_hackathon_forecast_dataset_s3_buckets_files" {
  type = set(string)
  description = "A set of all CxLink AWS Forecast S3 Buckets Files"
  default     = []
}

variable "cl_ir_ml_hackathon_forecasting_raw_bucket_name" {
  type = string
  description = "A set of all CxLink AWS Forecast S3 Raw Prefix Name"
}

variable "cl_ir_ml_hackathon_forecasting_curated_bucket_name" {
  type = string
  description = "A set of all CxLink AWS Forecast S3 Curated Prefix Name"
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

# ECR Values

variable "cl_ir_ml_hackathon_forecast_lambdas_ecr_repos" {
  type = list
  description = "CxLink AWS Forecast Lambdas ECR Repository Names"
}

variable "cl_ir_ml_hackathon_forecast_lambdas_ecr_repo_tag_mutability" {
  type = string
  description = "CxLink AWS Forecast Lambdas ECR Repositories Tag Mutability"
}

variable "cl_ir_ml_hackathon_forecast_lambdas_ecr_repo_encryption_type" {
  type = string
  description = "CxLink AWS Forecast Lambdas ECR Repositories Encryptyon Type"
}

variable "cl_ir_ml_hackathon_forecast_lambdas_ecr_repo_scan_on_push" {
  type = bool
  description = "Specifies whether CxLink AWS Forecast Lambdas ECR Repositories Scan on Push is enabled or not"
}

variable "cl_ir_ml_hackathon_forecast_lambdas_ecr_repo_timeout" {
  type = string
  description = "CxLink AWS Forecast Lambdas ECR Repositories Delete Timeout"
}

variable "cl_ir_ml_hackathon_forecast_lambda_architecture" {
  type = list
  description = "CxLink Hackathon Empathy Lambda Architecture"
}

# CxLink AWS Forecast QueryForecast Lambda Values

variable "cl_ir_ml_hackathon_forecast_query_lambda_test_mode" {
  type = string
  description = "CxLink AWS Forecast Query Lambda Test Mode"
}

variable "cl_ir_ml_hackathon_forecast_dataset_group_name" {
  type = string
  description = "CxLink AWS Forecast Forecast Dataset Group Name"
}

variable "cl_ir_ml_hackathon_forecast_use_case" {
  type = string
  description = "CxLink AWS Forecast Use Case"
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_ecr_repo" {
  type = string
  description = "CxLink AWS Forecast Query Lambda ECR Repo Name"
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_security_group_name" {
  type = string
  description = "CxLink AWS Forecast Query Lambda Security Group Namee"
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_role_name" {
  type = string
  description = "CxLink AWS Forecast Query Lambda IAM Role Name"
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_role_policy_name" {
  type = string
  description = "CxLink AWS Forecast Query Lambda IAM Role Policy Name"
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_image_tag" {
  type = string
  description = "CxLink AWS Forecast Query Lambda Lambda Function ECR tag"
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_sqs_dlq_name" {
  type = string
  description = "CxLink AWS Forecast Query Lambda Function DLQ Name"
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_sqs_dlq_delay" {
  type = number
  description = "CxLink AWS Forecast Query Lambda Function DLQ Delay"
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_sqs_dlq_max_size" {
  type = number
  description = "CxLink AWS Forecast Query Lambda Function DQL Max Size"
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_sqs_dlq_retention" {
  type = number
  description = "CxLink AWS Forecast Query Lambda Function DLQ Retention"

}

variable "cl_ir_ml_hackathon_forecast_query_lambda_sqs_dlq_wait_time" {
  type = number
  description = "CxLink AWS Forecast Query Lambda Function Wait Time"
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_function_publish_enabled" {
  type = bool
  description = "CxLink AWS Forecast Query Lambda Function"
  default = false
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_function_concurrency" {
  type = number
  description = "CxLink AWS Forecast Query Lambda Function Concurrency"
  default = 1
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_tracing_mode" {
  type = string
  description = "CxLink AWS Forecast Query Lambda Function X-Ray Tracing mode (PassThrough or Active)"
  default = "PassThrough"
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_function_ephemeral_size" {
  type = number
  description = "CxLink AWS Forecast Query Lambda Function Local Ephemeral Size"
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_subnet_ids" {
  type = list
  description = "CxLink AWS Forecast Query Lambda Function Subnet Ids"
  default = []
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_sns_topic_name" {
  type = string
  description = "CxLink AWS Forecast Query Lambda Function Invokation SNS Topic"
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_function_name" {
  type = string
  description = "CxLink AWS Forecast Query Lambda Function Name"
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_handler" {
  type = string
  description = "CxLink AWS Forecast Query Lambda Function Handler"
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_runtime" {
  type = string
  description = "CxLink AWS Forecast Query Lambda Function Runtime"
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_timeout" {
  type = number
  description = "CxLink AWS Forecast Query Lambda Function Timeout"
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_package_type" {
  type = string
  description = "CxLink AWS Forecast Query Lambda Function Package Type"
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_memory" {
  type = number
  description = "CxLink AWS Forecast Query Lambda Function Memory"
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_description" {
  type = string
  description = "CxLink AWS Forecast Query Lambda Function Description"
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_alias_name" {
  type = string
  description = "CxLink AWS Forecast Query Lambda Function Alias Name"
}

variable "cl_ir_ml_hackathon_forecast_query_lambda_alias_description" {
  type = string
  description = "CxLink AWS Forecast Query Lambda Function Description"
}

# CxLink Hackathon Empathy extract Lambda Values

variable "cl_ir_hackathon_empathy_extract_lambda_ecr_repo" {
  type = string
  description = "CxLink Hackathon Empathy extract Lambda ECR Repo Name"
}

variable "cl_ir_hackathon_empathy_extract_lambda_security_group_name" {
  type = string
  description = "CxLink Hackathon Empathy extract Lambda Security Group Namee"
}

variable "cl_ir_hackathon_empathy_extract_lambda_role_name" {
  type = string
  description = "CxLink Hackathon Empathy extract Lambda IAM Role Name"
}

variable "cl_ir_hackathon_empathy_extract_lambda_role_policy_name" {
  type = string
  description = "CxLink Hackathon Empathy extract Lambda IAM Role Policy Name"
}

variable "cl_ir_hackathon_empathy_extract_lambda_image_tag" {
  type = string
  description = "CxLink Hackathon Empathy extract Lambda Lambda Function ECR tag"
}

variable "cl_ir_hackathon_empathy_extract_lambda_sqs_dlq_name" {
  type = string
  description = "CxLink Hackathon Empathy extract Lambda Function DLQ Name"
}

variable "cl_ir_hackathon_empathy_extract_lambda_sqs_dlq_delay" {
  type = number
  description = "CxLink Hackathon Empathy extract Lambda Function DLQ Delay"
}

variable "cl_ir_hackathon_empathy_extract_lambda_sqs_dlq_max_size" {
  type = number
  description = "CxLink Hackathon Empathy extract Lambda Function DQL Max Size"
}

variable "cl_ir_hackathon_empathy_extract_lambda_sqs_dlq_retention" {
  type = number
  description = "CxLink Hackathon Empathy extract Lambda Function DLQ Retention"

}

variable "cl_ir_hackathon_empathy_extract_lambda_sqs_dlq_wait_time" {
  type = number
  description = "CxLink Hackathon Empathy extract Lambda Function Wait Time"
}

variable "cl_ir_hackathon_empathy_extract_lambda_function_publish_enabled" {
  type = bool
  description = "CxLink Hackathon Empathy extract Lambda Function"
  default = false
}

variable "cl_ir_hackathon_empathy_extract_lambda_function_concurrency" {
  type = number
  description = "CxLink Hackathon Empathy extract Lambda Function Concurrency"
  default = 1
}

variable "cl_ir_hackathon_empathy_extract_lambda_tracing_mode" {
  type = string
  description = "CxLink Hackathon Empathy extract Lambda Function X-Ray Tracing mode (PassThrough or Active)"
  default = "PassThrough"
}

variable "cl_ir_hackathon_empathy_extract_lambda_function_ephemeral_size" {
  type = number
  description = "CxLink Hackathon Empathy extract Lambda Function Local Ephemeral Size"
}

variable "cl_ir_hackathon_empathy_extract_lambda_subnet_ids" {
  type = list
  description = "CxLink Hackathon Empathy extract Lambda Function Subnet Ids"
  default = []
}

variable "cl_ir_hackathon_empathy_extract_lambda_sns_topic_name" {
  type = string
  description = "CxLink Hackathon Empathy extract Lambda Function Invokation SNS Topic"
}

variable "cl_ir_hackathon_empathy_extract_lambda_function_name" {
  type = string
  description = "CxLink Hackathon Empathy extract Lambda Function Name"
}

variable "cl_ir_hackathon_empathy_extract_lambda_handler" {
  type = string
  description = "CxLink Hackathon Empathy extract Lambda Function Handler"
}

variable "cl_ir_hackathon_empathy_extract_lambda_runtime" {
  type = string
  description = "CxLink Hackathon Empathy extract Lambda Function Runtime"
}

variable "cl_ir_hackathon_empathy_extract_lambda_timeout" {
  type = number
  description = "CxLink Hackathon Empathy extract Lambda Function Timeout"
}

variable "cl_ir_hackathon_empathy_extract_lambda_package_type" {
  type = string
  description = "CxLink Hackathon Empathy extract Lambda Function Package Type"
}

variable "cl_ir_hackathon_empathy_extract_lambda_memory" {
  type = number
  description = "CxLink Hackathon Empathy extract Lambda Function Memory"
}

variable "cl_ir_hackathon_empathy_extract_lambda_description" {
  type = string
  description = "CxLink Hackathon Empathy extract Lambda Function Description"
}

variable "cl_ir_hackathon_empathy_extract_lambda_alias_name" {
  type = string
  description = "CxLink Hackathon Empathy extract Lambda Function Alias Name"
}

variable "cl_ir_hackathon_empathy_extract_lambda_alias_description" {
  type = string
  description = "CxLink Hackathon Empathy extract Lambda Function Description"
}

# CxLink Hackathon Empathy filter Lambda Values

variable "cl_ir_hackathon_empathy_filter_lambda_ecr_repo" {
  type = string
  description = "CxLink Hackathon Empathy filter Lambda ECR Repo Name"
}

variable "cl_ir_hackathon_empathy_filter_lambda_security_group_name" {
  type = string
  description = "CxLink Hackathon Empathy filter Lambda Security Group Namee"
}

variable "cl_ir_hackathon_empathy_filter_lambda_role_name" {
  type = string
  description = "CxLink Hackathon Empathy filter Lambda IAM Role Name"
}

variable "cl_ir_hackathon_empathy_filter_lambda_role_policy_name" {
  type = string
  description = "CxLink Hackathon Empathy filter Lambda IAM Role Policy Name"
}

variable "cl_ir_hackathon_empathy_filter_lambda_image_tag" {
  type = string
  description = "CxLink Hackathon Empathy filter Lambda Lambda Function ECR tag"
}

variable "cl_ir_hackathon_empathy_filter_lambda_sqs_dlq_name" {
  type = string
  description = "CxLink Hackathon Empathy filter Lambda Function DLQ Name"
}

variable "cl_ir_hackathon_empathy_filter_lambda_sqs_dlq_delay" {
  type = number
  description = "CxLink Hackathon Empathy filter Lambda Function DLQ Delay"
}

variable "cl_ir_hackathon_empathy_filter_lambda_sqs_dlq_max_size" {
  type = number
  description = "CxLink Hackathon Empathy filter Lambda Function DQL Max Size"
}

variable "cl_ir_hackathon_empathy_filter_lambda_sqs_dlq_retention" {
  type = number
  description = "CxLink Hackathon Empathy filter Lambda Function DLQ Retention"

}

variable "cl_ir_hackathon_empathy_filter_lambda_sqs_dlq_wait_time" {
  type = number
  description = "CxLink Hackathon Empathy filter Lambda Function Wait Time"
}

variable "cl_ir_hackathon_empathy_filter_lambda_function_publish_enabled" {
  type = bool
  description = "CxLink Hackathon Empathy filter Lambda Function"
  default = false
}

variable "cl_ir_hackathon_empathy_filter_lambda_function_concurrency" {
  type = number
  description = "CxLink Hackathon Empathy filter Lambda Function Concurrency"
  default = 1
}

variable "cl_ir_hackathon_empathy_filter_lambda_tracing_mode" {
  type = string
  description = "CxLink Hackathon Empathy filter Lambda Function X-Ray Tracing mode (PassThrough or Active)"
  default = "PassThrough"
}

variable "cl_ir_hackathon_empathy_filter_lambda_function_ephemeral_size" {
  type = number
  description = "CxLink Hackathon Empathy filter Lambda Function Local Ephemeral Size"
}

variable "cl_ir_hackathon_empathy_filter_lambda_subnet_ids" {
  type = list
  description = "CxLink Hackathon Empathy filter Lambda Function Subnet Ids"
  default = []
}

variable "cl_ir_hackathon_empathy_filter_lambda_sns_topic_name" {
  type = string
  description = "CxLink Hackathon Empathy filter Lambda Function Invokation SNS Topic"
}

variable "cl_ir_hackathon_empathy_filter_lambda_function_name" {
  type = string
  description = "CxLink Hackathon Empathy filter Lambda Function Name"
}

variable "cl_ir_hackathon_empathy_filter_lambda_handler" {
  type = string
  description = "CxLink Hackathon Empathy filter Lambda Function Handler"
}

variable "cl_ir_hackathon_empathy_filter_lambda_runtime" {
  type = string
  description = "CxLink Hackathon Empathy filter Lambda Function Runtime"
}

variable "cl_ir_hackathon_empathy_filter_lambda_timeout" {
  type = number
  description = "CxLink Hackathon Empathy filter Lambda Function Timeout"
}

variable "cl_ir_hackathon_empathy_filter_lambda_package_type" {
  type = string
  description = "CxLink Hackathon Empathy filter Lambda Function Package Type"
}

variable "cl_ir_hackathon_empathy_filter_lambda_memory" {
  type = number
  description = "CxLink Hackathon Empathy filter Lambda Function Memory"
}

variable "cl_ir_hackathon_empathy_filter_lambda_description" {
  type = string
  description = "CxLink Hackathon Empathy filter Lambda Function Description"
}

variable "cl_ir_hackathon_empathy_filter_lambda_alias_name" {
  type = string
  description = "CxLink Hackathon Empathy filter Lambda Function Alias Name"
}

variable "cl_ir_hackathon_empathy_filter_lambda_alias_description" {
  type = string
  description = "CxLink Hackathon Empathy filter Lambda Function Description"
}

# CxLink Hackathon Empathy Consolidation Lambda Values

variable "cl_ir_hackathon_empathy_consolidation_lambda_ecr_repo" {
  type = string
  description = "CxLink Hackathon Empathy consolidation Lambda ECR Repo Name"
}

variable "cl_ir_hackathon_empathy_consolidation_lambda_security_group_name" {
  type = string
  description = "CxLink Hackathon Empathy consolidation Lambda Security Group Namee"
}

variable "cl_ir_hackathon_empathy_consolidation_lambda_role_name" {
  type = string
  description = "CxLink Hackathon Empathy consolidation Lambda IAM Role Name"
}

variable "cl_ir_hackathon_empathy_consolidation_lambda_role_policy_name" {
  type = string
  description = "CxLink Hackathon Empathy consolidation Lambda IAM Role Policy Name"
}

variable "cl_ir_hackathon_empathy_consolidation_lambda_image_tag" {
  type = string
  description = "CxLink Hackathon Empathy consolidation Lambda Lambda Function ECR tag"
}

variable "cl_ir_hackathon_empathy_consolidation_lambda_sqs_dlq_name" {
  type = string
  description = "CxLink Hackathon Empathy consolidation Lambda Function DLQ Name"
}

variable "cl_ir_hackathon_empathy_consolidation_lambda_sqs_dlq_delay" {
  type = number
  description = "CxLink Hackathon Empathy consolidation Lambda Function DLQ Delay"
}

variable "cl_ir_hackathon_empathy_consolidation_lambda_sqs_dlq_max_size" {
  type = number
  description = "CxLink Hackathon Empathy consolidation Lambda Function DQL Max Size"
}

variable "cl_ir_hackathon_empathy_consolidation_lambda_sqs_dlq_retention" {
  type = number
  description = "CxLink Hackathon Empathy consolidation Lambda Function DLQ Retention"

}

variable "cl_ir_hackathon_empathy_consolidation_lambda_sqs_dlq_wait_time" {
  type = number
  description = "CxLink Hackathon Empathy consolidation Lambda Function Wait Time"
}

variable "cl_ir_hackathon_empathy_consolidation_lambda_function_publish_enabled" {
  type = bool
  description = "CxLink Hackathon Empathy consolidation Lambda Function"
  default = false
}

variable "cl_ir_hackathon_empathy_consolidation_lambda_function_concurrency" {
  type = number
  description = "CxLink Hackathon Empathy consolidation Lambda Function Concurrency"
  default = 1
}

variable "cl_ir_hackathon_empathy_consolidation_lambda_tracing_mode" {
  type = string
  description = "CxLink Hackathon Empathy consolidation Lambda Function X-Ray Tracing mode (PassThrough or Active)"
  default = "PassThrough"
}

variable "cl_ir_hackathon_empathy_consolidation_lambda_function_ephemeral_size" {
  type = number
  description = "CxLink Hackathon Empathy consolidation Lambda Function Local Ephemeral Size"
}

variable "cl_ir_hackathon_empathy_consolidation_lambda_subnet_ids" {
  type = list
  description = "CxLink Hackathon Empathy consolidation Lambda Function Subnet Ids"
  default = []
}

variable "cl_ir_hackathon_empathy_consolidation_lambda_sns_topic_name" {
  type = string
  description = "CxLink Hackathon Empathy consolidation Lambda Function Invokation SNS Topic"
}

variable "cl_ir_hackathon_empathy_consolidation_lambda_function_name" {
  type = string
  description = "CxLink Hackathon Empathy consolidation Lambda Function Name"
}

variable "cl_ir_hackathon_empathy_consolidation_lambda_handler" {
  type = string
  description = "CxLink Hackathon Empathy consolidation Lambda Function Handler"
}

variable "cl_ir_hackathon_empathy_consolidation_lambda_runtime" {
  type = string
  description = "CxLink Hackathon Empathy consolidation Lambda Function Runtime"
}

variable "cl_ir_hackathon_empathy_consolidation_lambda_timeout" {
  type = number
  description = "CxLink Hackathon Empathy consolidation Lambda Function Timeout"
}

variable "cl_ir_hackathon_empathy_consolidation_lambda_package_type" {
  type = string
  description = "CxLink Hackathon Empathy consolidation Lambda Function Package Type"
}

variable "cl_ir_hackathon_empathy_consolidation_lambda_memory" {
  type = number
  description = "CxLink Hackathon Empathy consolidation Lambda Function Memory"
}

variable "cl_ir_hackathon_empathy_consolidation_lambda_description" {
  type = string
  description = "CxLink Hackathon Empathy consolidation Lambda Function Description"
}

variable "cl_ir_hackathon_empathy_consolidation_lambda_alias_name" {
  type = string
  description = "CxLink Hackathon Empathy consolidation Lambda Function Alias Name"
}

variable "cl_ir_hackathon_empathy_consolidation_lambda_alias_description" {
  type = string
  description = "CxLink Hackathon Empathy consolidation Lambda Function Description"
}

# CxLink Hackathon Empathy Start Training Lambda Values

variable "cl_ir_hackathon_empathy_start_training_lambda_ecr_repo" {
  type = string
  description = "CxLink Hackathon Empathy Start Training Lambda ECR Repo Name"
}

variable "cl_ir_hackathon_empathy_start_training_lambda_security_group_name" {
  type = string
  description = "CxLink Hackathon Empathy Start Training Lambda Security Group Namee"
}

variable "cl_ir_hackathon_empathy_start_training_lambda_role_name" {
  type = string
  description = "CxLink Hackathon Empathy Start Training Lambda IAM Role Name"
}

variable "cl_ir_hackathon_empathy_start_training_lambda_role_policy_name" {
  type = string
  description = "CxLink Hackathon Empathy Start Training Lambda IAM Role Policy Name"
}

variable "cl_ir_hackathon_empathy_start_training_lambda_image_tag" {
  type = string
  description = "CxLink Hackathon Empathy Start Training Lambda Lambda Function ECR tag"
}

variable "cl_ir_hackathon_empathy_start_training_lambda_sqs_dlq_name" {
  type = string
  description = "CxLink Hackathon Empathy Start Training Lambda Function DLQ Name"
}

variable "cl_ir_hackathon_empathy_start_training_lambda_sqs_dlq_delay" {
  type = number
  description = "CxLink Hackathon Empathy Start Training Lambda Function DLQ Delay"
}

variable "cl_ir_hackathon_empathy_start_training_lambda_sqs_dlq_max_size" {
  type = number
  description = "CxLink Hackathon Empathy Start Training Lambda Function DQL Max Size"
}

variable "cl_ir_hackathon_empathy_start_training_lambda_sqs_dlq_retention" {
  type = number
  description = "CxLink Hackathon Empathy Start Training Lambda Function DLQ Retention"

}

variable "cl_ir_hackathon_empathy_start_training_lambda_sqs_dlq_wait_time" {
  type = number
  description = "CxLink Hackathon Empathy Start Training Lambda Function Wait Time"
}

variable "cl_ir_hackathon_empathy_start_training_lambda_function_publish_enabled" {
  type = bool
  description = "CxLink Hackathon Empathy Start Training Lambda Function"
  default = false
}

variable "cl_ir_hackathon_empathy_start_training_lambda_function_concurrency" {
  type = number
  description = "CxLink Hackathon Empathy Start Training Lambda Function Concurrency"
  default = 1
}

variable "cl_ir_hackathon_empathy_start_training_lambda_tracing_mode" {
  type = string
  description = "CxLink Hackathon Empathy Start Training Lambda Function X-Ray Tracing mode (PassThrough or Active)"
  default = "PassThrough"
}

variable "cl_ir_hackathon_empathy_start_training_lambda_function_ephemeral_size" {
  type = number
  description = "CxLink Hackathon Empathy Start Training Lambda Function Local Ephemeral Size"
}

variable "cl_ir_hackathon_empathy_start_training_lambda_subnet_ids" {
  type = list
  description = "CxLink Hackathon Empathy Start Training Lambda Function Subnet Ids"
  default = []
}

variable "cl_ir_hackathon_empathy_start_training_lambda_sns_topic_name" {
  type = string
  description = "CxLink Hackathon Empathy Start Training Lambda Function Invokation SNS Topic"
}

variable "cl_ir_hackathon_empathy_start_training_lambda_function_name" {
  type = string
  description = "CxLink Hackathon Empathy Start Training Lambda Function Name"
}

variable "cl_ir_hackathon_empathy_start_training_lambda_handler" {
  type = string
  description = "CxLink Hackathon Empathy Start Training Lambda Function Handler"
}

variable "cl_ir_hackathon_empathy_start_training_lambda_runtime" {
  type = string
  description = "CxLink Hackathon Empathy Start Training Lambda Function Runtime"
}

variable "cl_ir_hackathon_empathy_start_training_lambda_timeout" {
  type = number
  description = "CxLink Hackathon Empathy Start Training Lambda Function Timeout"
}

variable "cl_ir_hackathon_empathy_start_training_lambda_package_type" {
  type = string
  description = "CxLink Hackathon Empathy Start Training Lambda Function Package Type"
}

variable "cl_ir_hackathon_empathy_start_training_lambda_memory" {
  type = number
  description = "CxLink Hackathon Empathy Start Training Lambda Function Memory"
}

variable "cl_ir_hackathon_empathy_start_training_lambda_description" {
  type = string
  description = "CxLink Hackathon Empathy Start Training Lambda Function Description"
}

variable "cl_ir_hackathon_empathy_start_training_lambda_alias_name" {
  type = string
  description = "CxLink Hackathon Empathy Start Training Lambda Function Alias Name"
}

variable "cl_ir_hackathon_empathy_start_training_lambda_alias_description" {
  type = string
  description = "CxLink Hackathon Empathy Start Training Lambda Function Description"
}

variable "cl_ir_hackathon_empathy_codepipeline_name" {
  type = string
  description = "CxLink Hackathon Empathy Forecast Training CodePipeline Name"
}

# CxLink Hackathon Empathy Audio Lambda Values

variable "cl_ir_hackathon_empathy_audio_lambda_ecr_repo" {
  type = string
  description = "CxLink Hackathon Empathy audio Lambda ECR Repo Name"
}

variable "cl_ir_hackathon_empathy_audio_lambda_security_group_name" {
  type = string
  description = "CxLink Hackathon Empathy audio Lambda Security Group Namee"
}

variable "cl_ir_hackathon_empathy_audio_lambda_role_name" {
  type = string
  description = "CxLink Hackathon Empathy audio Lambda IAM Role Name"
}

variable "cl_ir_hackathon_empathy_audio_lambda_role_policy_name" {
  type = string
  description = "CxLink Hackathon Empathy audio Lambda IAM Role Policy Name"
}

variable "cl_ir_hackathon_empathy_audio_lambda_image_tag" {
  type = string
  description = "CxLink Hackathon Empathy audio Lambda Lambda Function ECR tag"
}

variable "cl_ir_hackathon_empathy_audio_lambda_sqs_dlq_name" {
  type = string
  description = "CxLink Hackathon Empathy audio Lambda Function DLQ Name"
}

variable "cl_ir_hackathon_empathy_audio_lambda_sqs_dlq_delay" {
  type = number
  description = "CxLink Hackathon Empathy audio Lambda Function DLQ Delay"
}

variable "cl_ir_hackathon_empathy_audio_lambda_sqs_dlq_max_size" {
  type = number
  description = "CxLink Hackathon Empathy audio Lambda Function DQL Max Size"
}

variable "cl_ir_hackathon_empathy_audio_lambda_sqs_dlq_retention" {
  type = number
  description = "CxLink Hackathon Empathy audio Lambda Function DLQ Retention"

}

variable "cl_ir_hackathon_empathy_audio_lambda_sqs_dlq_wait_time" {
  type = number
  description = "CxLink Hackathon Empathy audio Lambda Function Wait Time"
}

variable "cl_ir_hackathon_empathy_audio_lambda_function_publish_enabled" {
  type = bool
  description = "CxLink Hackathon Empathy audio Lambda Function"
  default = false
}

variable "cl_ir_hackathon_empathy_audio_lambda_function_concurrency" {
  type = number
  description = "CxLink Hackathon Empathy audio Lambda Function Concurrency"
  default = 1
}

variable "cl_ir_hackathon_empathy_audio_lambda_tracing_mode" {
  type = string
  description = "CxLink Hackathon Empathy audio Lambda Function X-Ray Tracing mode (PassThrough or Active)"
  default = "PassThrough"
}

variable "cl_ir_hackathon_empathy_audio_lambda_function_ephemeral_size" {
  type = number
  description = "CxLink Hackathon Empathy audio Lambda Function Local Ephemeral Size"
}

variable "cl_ir_hackathon_empathy_audio_lambda_subnet_ids" {
  type = list
  description = "CxLink Hackathon Empathy audio Lambda Function Subnet Ids"
  default = []
}

variable "cl_ir_hackathon_empathy_audio_lambda_sns_topic_name" {
  type = string
  description = "CxLink Hackathon Empathy audio Lambda Function Invokation SNS Topic"
}

variable "cl_ir_hackathon_empathy_audio_lambda_function_name" {
  type = string
  description = "CxLink Hackathon Empathy audio Lambda Function Name"
}

variable "cl_ir_hackathon_empathy_audio_lambda_handler" {
  type = string
  description = "CxLink Hackathon Empathy audio Lambda Function Handler"
}

variable "cl_ir_hackathon_empathy_audio_lambda_runtime" {
  type = string
  description = "CxLink Hackathon Empathy audio Lambda Function Runtime"
}

variable "cl_ir_hackathon_empathy_audio_lambda_timeout" {
  type = number
  description = "CxLink Hackathon Empathy audio Lambda Function Timeout"
}

variable "cl_ir_hackathon_empathy_audio_lambda_package_type" {
  type = string
  description = "CxLink Hackathon Empathy audio Lambda Function Package Type"
}

variable "cl_ir_hackathon_empathy_audio_lambda_memory" {
  type = number
  description = "CxLink Hackathon Empathy audio Lambda Function Memory"
}

variable "cl_ir_hackathon_empathy_audio_lambda_description" {
  type = string
  description = "CxLink Hackathon Empathy audio Lambda Function Description"
}

variable "cl_ir_hackathon_empathy_audio_lambda_alias_name" {
  type = string
  description = "CxLink Hackathon Empathy audio Lambda Function Alias Name"
}

variable "cl_ir_hackathon_empathy_audio_lambda_alias_description" {
  type = string
  description = "CxLink Hackathon Empathy audio Lambda Function Description"
}
# CxLink Hackathon Empathy Text Lambda Values

variable "cl_ir_hackathon_empathy_text_lambda_ecr_repo" {
  type = string
  description = "CxLink Hackathon Empathy text Lambda ECR Repo Name"
}

variable "cl_ir_hackathon_empathy_text_lambda_security_group_name" {
  type = string
  description = "CxLink Hackathon Empathy text Lambda Security Group Namee"
}

variable "cl_ir_hackathon_empathy_text_lambda_role_name" {
  type = string
  description = "CxLink Hackathon Empathy text Lambda IAM Role Name"
}

variable "cl_ir_hackathon_empathy_text_lambda_role_policy_name" {
  type = string
  description = "CxLink Hackathon Empathy text Lambda IAM Role Policy Name"
}

variable "cl_ir_hackathon_empathy_text_lambda_image_tag" {
  type = string
  description = "CxLink Hackathon Empathy text Lambda Lambda Function ECR tag"
}

variable "cl_ir_hackathon_empathy_text_lambda_sqs_dlq_name" {
  type = string
  description = "CxLink Hackathon Empathy text Lambda Function DLQ Name"
}

variable "cl_ir_hackathon_empathy_text_lambda_sqs_dlq_delay" {
  type = number
  description = "CxLink Hackathon Empathy text Lambda Function DLQ Delay"
}

variable "cl_ir_hackathon_empathy_text_lambda_sqs_dlq_max_size" {
  type = number
  description = "CxLink Hackathon Empathy text Lambda Function DQL Max Size"
}

variable "cl_ir_hackathon_empathy_text_lambda_sqs_dlq_retention" {
  type = number
  description = "CxLink Hackathon Empathy text Lambda Function DLQ Retention"

}

variable "cl_ir_hackathon_empathy_text_lambda_sqs_dlq_wait_time" {
  type = number
  description = "CxLink Hackathon Empathy text Lambda Function Wait Time"
}

variable "cl_ir_hackathon_empathy_text_lambda_function_publish_enabled" {
  type = bool
  description = "CxLink Hackathon Empathy text Lambda Function"
  default = false
}

variable "cl_ir_hackathon_empathy_text_lambda_function_concurrency" {
  type = number
  description = "CxLink Hackathon Empathy text Lambda Function Concurrency"
  default = 1
}

variable "cl_ir_hackathon_empathy_text_lambda_tracing_mode" {
  type = string
  description = "CxLink Hackathon Empathy text Lambda Function X-Ray Tracing mode (PassThrough or Active)"
  default = "PassThrough"
}

variable "cl_ir_hackathon_empathy_text_lambda_function_ephemeral_size" {
  type = number
  description = "CxLink Hackathon Empathy text Lambda Function Local Ephemeral Size"
}

variable "cl_ir_hackathon_empathy_text_lambda_subnet_ids" {
  type = list
  description = "CxLink Hackathon Empathy text Lambda Function Subnet Ids"
  default = []
}

variable "cl_ir_hackathon_empathy_text_lambda_sns_topic_name" {
  type = string
  description = "CxLink Hackathon Empathy text Lambda Function Invokation SNS Topic"
}

variable "cl_ir_hackathon_empathy_text_lambda_function_name" {
  type = string
  description = "CxLink Hackathon Empathy text Lambda Function Name"
}

variable "cl_ir_hackathon_empathy_text_lambda_handler" {
  type = string
  description = "CxLink Hackathon Empathy text Lambda Function Handler"
}

variable "cl_ir_hackathon_empathy_text_lambda_runtime" {
  type = string
  description = "CxLink Hackathon Empathy text Lambda Function Runtime"
}

variable "cl_ir_hackathon_empathy_text_lambda_timeout" {
  type = number
  description = "CxLink Hackathon Empathy text Lambda Function Timeout"
}

variable "cl_ir_hackathon_empathy_text_lambda_package_type" {
  type = string
  description = "CxLink Hackathon Empathy text Lambda Function Package Type"
}

variable "cl_ir_hackathon_empathy_text_lambda_memory" {
  type = number
  description = "CxLink Hackathon Empathy text Lambda Function Memory"
}

variable "cl_ir_hackathon_empathy_text_lambda_description" {
  type = string
  description = "CxLink Hackathon Empathy text Lambda Function Description"
}

variable "cl_ir_hackathon_empathy_text_lambda_alias_name" {
  type = string
  description = "CxLink Hackathon Empathy text Lambda Function Alias Name"
}

variable "cl_ir_hackathon_empathy_text_lambda_alias_description" {
  type = string
  description = "CxLink Hackathon Empathy text Lambda Function Description"
}
