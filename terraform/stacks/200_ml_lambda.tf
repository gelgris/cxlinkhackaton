module "cl_hackathon_ea_lambdas" {

  source  = "../../terraform/modules/ml/lambda"

  owner                                 = var.owner
  project                               = var.project
  region                                = var.region
  vpc_id                                = var.vpc_id
  stage                                 = var.stage
  prefix                                = var.prefix
  default_profile			= var.default_profile # Needed for ECR publishing

  # Global KMS Values

  cl_ir_ecr_kms_key_id                                          = var.cl_ir_ecr_kms_key_id
  cl_ir_cloudwatch_kms_key_id                                   = var.cl_ir_cloudwatch_kms_key_id
  cl_ir_lambda_kms_key_id                                       = var.cl_ir_lambda_kms_key_id
  cl_ir_s3_kms_key_id                                           = var.cl_ir_s3_kms_key_id


  # CxLink AWS Forecast Lambda ECR Repos

  cl_ir_ml_hackathon_forecast_lambdas_ecr_repos			= [
									"cl-ir-hackathon-empathy-consolidation-lambda",
									"cl-ir-hackathon-empathy-filter-lambda",
									"cl-ir-hackathon-empathy-audio-lambda",
									"cl-ir-hackathon-empathy-text-lambda",
									"cl-ir-hackathon-empathy-extract-lambda",
									"cl-ir-hackathon-empathy-start-training-lambda",
									"cl-ir-ml-hackathon-forecast-query-lambda"
								  ]

  cl_ir_ml_hackathon_forecast_lambdas_ecr_repo_tag_mutability		= "MUTABLE"
  cl_ir_ml_hackathon_forecast_lambdas_ecr_repo_encryption_type		= "KMS"
  cl_ir_ml_hackathon_forecast_lambdas_ecr_repo_scan_on_push		= true
  cl_ir_ml_hackathon_forecast_lambdas_ecr_repo_timeout			= "20m"

  # CxLink AWS Forecasting S3 Buckets

  cl_ir_ml_hackathon_forecast_dataset_s3_buckets_files                  = fileset(path.module, "templates/forecast/s3_buckets/*.{yml,yaml}")
  cl_ir_ml_hackathon_forecast_customers_files                           = fileset(path.module, "templates/forecast/customers/*.{yml,yaml}")
  cl_ir_ml_hackathon_forecasting_raw_bucket_name			= "cl-ir-ml-hackathon-aws-forecast-raw-bucket-cruz-roja"
  cl_ir_ml_hackathon_forecasting_curated_bucket_name			= "cl-ir-ml-hackathon-aws-forecast-curated-bucket-cruz-roja"

  # CxLink Hackathon Empathy Global Lambda Values

  cl_ir_ml_hackathon_forecast_lambda_architecture			= ["x86_64"]

  # CxLink Hackathon Empathy Consolidation Lambda Values

  cl_ir_hackathon_empathy_consolidation_lambda_ecr_repo			= "cl-ir-hackathon-empathy-consolidation-lambda"

  cl_ir_hackathon_empathy_consolidation_lambda_function_name		= "cl-ir-hackathon-empathy-consolidation"
  cl_ir_hackathon_empathy_consolidation_lambda_image_tag		= "cl_ir_hackathon_empathy_consolidation_v1.0"
  cl_ir_hackathon_empathy_consolidation_lambda_sqs_dlq_name		= "cl-ir-hackathon-empathy-consolidation-dql"

  cl_ir_hackathon_empathy_consolidation_lambda_sqs_dlq_delay		= 90
  cl_ir_hackathon_empathy_consolidation_lambda_sqs_dlq_max_size		= 2048
  cl_ir_hackathon_empathy_consolidation_lambda_sqs_dlq_retention	= 86400
  cl_ir_hackathon_empathy_consolidation_lambda_sqs_dlq_wait_time	= 10

  cl_ir_hackathon_empathy_consolidation_lambda_function_publish_enabled	= true
  cl_ir_hackathon_empathy_consolidation_lambda_function_concurrency		= -1
  cl_ir_hackathon_empathy_consolidation_lambda_tracing_mode			= "PassThrough"
  cl_ir_hackathon_empathy_consolidation_lambda_function_ephemeral_size		= 512
  cl_ir_hackathon_empathy_consolidation_lambda_subnet_ids			= var.private_subnet_ids
  cl_ir_hackathon_empathy_consolidation_lambda_sns_topic_name			= "cl-ir-hackathon-empathy-consolidation-lambda"
  cl_ir_hackathon_empathy_consolidation_lambda_handler				= "cl-ir-hackathon-empathy-consolidation-lambda-handler.lambda_handler"
  cl_ir_hackathon_empathy_consolidation_lambda_runtime				= "go.1"
  cl_ir_hackathon_empathy_consolidation_lambda_timeout				= 900
  cl_ir_hackathon_empathy_consolidation_lambda_package_type			= "Image"
  cl_ir_hackathon_empathy_consolidation_lambda_memory				= 512
  cl_ir_hackathon_empathy_consolidation_lambda_description			= "CxLink Hackathon Empathy Consolidation Lambda"
  cl_ir_hackathon_empathy_consolidation_lambda_alias_name			= "cl-ir-hackathon-empathy-consolidation-lambda"
  cl_ir_hackathon_empathy_consolidation_lambda_alias_description		= "CxLink Hackathon Empathy consolidation Lambda"
  cl_ir_hackathon_empathy_consolidation_lambda_security_group_name		= "cl-ir-hackathon-empathy-consolidation-lambda"
  cl_ir_hackathon_empathy_consolidation_lambda_role_name			= "cl-ir-hackathon-empathy-consolidation-lambda"
  cl_ir_hackathon_empathy_consolidation_lambda_role_policy_name			= "cl-ir-hackathon-empathy-consolidation-lambda"

  # CxLink Hackathon Empathy Filter Lambda Values

  cl_ir_hackathon_empathy_filter_lambda_ecr_repo			= "cl-ir-hackathon-empathy-filter-lambda"

  cl_ir_hackathon_empathy_filter_lambda_function_name			= "cl-ir-hackathon-empathy-filter"
  cl_ir_hackathon_empathy_filter_lambda_image_tag			= "cl_ir_hackathon_empathy_filter_v1.0"
  cl_ir_hackathon_empathy_filter_lambda_sqs_dlq_name			= "cl-ir-hackathon-empathy-filter-dql"

  cl_ir_hackathon_empathy_filter_lambda_sqs_dlq_delay			= 90
  cl_ir_hackathon_empathy_filter_lambda_sqs_dlq_max_size		= 2048
  cl_ir_hackathon_empathy_filter_lambda_sqs_dlq_retention		= 86400
  cl_ir_hackathon_empathy_filter_lambda_sqs_dlq_wait_time		= 10

  cl_ir_hackathon_empathy_filter_lambda_function_publish_enabled	= true
  cl_ir_hackathon_empathy_filter_lambda_function_concurrency		= -1
  cl_ir_hackathon_empathy_filter_lambda_tracing_mode			= "PassThrough"
  cl_ir_hackathon_empathy_filter_lambda_function_ephemeral_size	= 512
  cl_ir_hackathon_empathy_filter_lambda_subnet_ids			= var.private_subnet_ids
  cl_ir_hackathon_empathy_filter_lambda_sns_topic_name			= "cl-ir-hackathon-empathy-filter-lambda"
  cl_ir_hackathon_empathy_filter_lambda_handler				= "cl-ir-hackathon-empathy-filter-lambda-handler.lambda_handler"
  cl_ir_hackathon_empathy_filter_lambda_runtime				= "go.1"
  cl_ir_hackathon_empathy_filter_lambda_timeout				= 900
  cl_ir_hackathon_empathy_filter_lambda_package_type			= "Image"
  cl_ir_hackathon_empathy_filter_lambda_memory				= 512
  cl_ir_hackathon_empathy_filter_lambda_description			= "CxLink Hackathon Empathy Filter Lambda"
  cl_ir_hackathon_empathy_filter_lambda_alias_name			= "cl-ir-hackathon-empathy-filter-lambda"
  cl_ir_hackathon_empathy_filter_lambda_alias_description		= "CxLink Hackathon Empathy filter Lambda"
  cl_ir_hackathon_empathy_filter_lambda_security_group_name		= "cl-ir-hackathon-empathy-filter-lambda"
  cl_ir_hackathon_empathy_filter_lambda_role_name			= "cl-ir-hackathon-empathy-filter-lambda"
  cl_ir_hackathon_empathy_filter_lambda_role_policy_name		= "cl-ir-hackathon-empathy-filter-lambda"

  # CxLink Hackathon Empathy Extract Lambda Values

  cl_ir_hackathon_empathy_extract_lambda_ecr_repo			= "cl-ir-hackathon-empathy-extract-lambda"

  cl_ir_hackathon_empathy_extract_lambda_function_name			= "cl-ir-hackathon-empathy-extract"
  cl_ir_hackathon_empathy_extract_lambda_image_tag			= "cl_ir_hackathon_empathy_extract_v1.0"
  cl_ir_hackathon_empathy_extract_lambda_sqs_dlq_name			= "cl-ir-hackathon-empathy-extract-dql"

  cl_ir_hackathon_empathy_extract_lambda_sqs_dlq_delay			= 90
  cl_ir_hackathon_empathy_extract_lambda_sqs_dlq_max_size		= 2048
  cl_ir_hackathon_empathy_extract_lambda_sqs_dlq_retention		= 86400
  cl_ir_hackathon_empathy_extract_lambda_sqs_dlq_wait_time		= 10

  cl_ir_hackathon_empathy_extract_lambda_function_publish_enabled	= true
  cl_ir_hackathon_empathy_extract_lambda_function_concurrency		= -1
  cl_ir_hackathon_empathy_extract_lambda_tracing_mode			= "PassThrough"
  cl_ir_hackathon_empathy_extract_lambda_function_ephemeral_size	= 512
  cl_ir_hackathon_empathy_extract_lambda_subnet_ids			= var.private_subnet_ids
  cl_ir_hackathon_empathy_extract_lambda_sns_topic_name			= "cl-ir-hackathon-empathy-extract-lambda"
  cl_ir_hackathon_empathy_extract_lambda_handler			= "cl-ir-hackathon-empathy-extract-lambda-handler.lambda_handler"
  cl_ir_hackathon_empathy_extract_lambda_runtime			= "go.1"
  cl_ir_hackathon_empathy_extract_lambda_timeout			= 900
  cl_ir_hackathon_empathy_extract_lambda_package_type			= "Image"
  cl_ir_hackathon_empathy_extract_lambda_memory				= 512
  cl_ir_hackathon_empathy_extract_lambda_description			= "CxLink Hackathon Empathy Extract Lambda"
  cl_ir_hackathon_empathy_extract_lambda_alias_name			= "cl-ir-hackathon-empathy-extract-lambda"
  cl_ir_hackathon_empathy_extract_lambda_alias_description		= "CxLink Hackathon Empathy extract Lambda"
  cl_ir_hackathon_empathy_extract_lambda_security_group_name		= "cl-ir-hackathon-empathy-extract-lambda"
  cl_ir_hackathon_empathy_extract_lambda_role_name			= "cl-ir-hackathon-empathy-extract-lambda"
  cl_ir_hackathon_empathy_extract_lambda_role_policy_name		= "cl-ir-hackathon-empathy-extract-lambda"

  # CxLink Hackathon Empathy Start Training Lambda Values

  cl_ir_hackathon_empathy_start_training_lambda_ecr_repo			= "cl-ir-hackathon-empathy-start-training-lambda"

  cl_ir_hackathon_empathy_start_training_lambda_function_name			= "cl-ir-hackathon-empathy-start-training"
  cl_ir_hackathon_empathy_start_training_lambda_image_tag			= "cl_ir_hackathon_empathy_start_training_v1.0"
  cl_ir_hackathon_empathy_start_training_lambda_sqs_dlq_name			= "cl-ir-hackathon-empathy-start-training-dql"

  cl_ir_hackathon_empathy_start_training_lambda_sqs_dlq_delay			= 90
  cl_ir_hackathon_empathy_start_training_lambda_sqs_dlq_max_size		= 2048
  cl_ir_hackathon_empathy_start_training_lambda_sqs_dlq_retention		= 86400
  cl_ir_hackathon_empathy_start_training_lambda_sqs_dlq_wait_time		= 10

  cl_ir_hackathon_empathy_start_training_lambda_function_publish_enabled	= true
  cl_ir_hackathon_empathy_start_training_lambda_function_concurrency		= -1
  cl_ir_hackathon_empathy_start_training_lambda_tracing_mode			= "PassThrough"
  cl_ir_hackathon_empathy_start_training_lambda_function_ephemeral_size	= 512
  cl_ir_hackathon_empathy_start_training_lambda_subnet_ids			= var.private_subnet_ids
  cl_ir_hackathon_empathy_start_training_lambda_sns_topic_name			= "cl-ir-hackathon-empathy-start-training-lambda"
  cl_ir_hackathon_empathy_start_training_lambda_handler				= "cl-ir-hackathon-empathy-start-training-lambda-handler.lambda_handler"
  cl_ir_hackathon_empathy_start_training_lambda_runtime				= "python3.8"
  cl_ir_hackathon_empathy_start_training_lambda_timeout				= 900
  cl_ir_hackathon_empathy_start_training_lambda_package_type			= "Image"
  cl_ir_hackathon_empathy_start_training_lambda_memory				= 512
  cl_ir_hackathon_empathy_start_training_lambda_description			= "CxLink Hackathon Empathy start_training Lambda"
  cl_ir_hackathon_empathy_start_training_lambda_alias_name			= "cl-ir-hackathon-empathy-start-training-lambda"
  cl_ir_hackathon_empathy_start_training_lambda_alias_description		= "CxLink Hackathon Empathy start_training Lambda"
  cl_ir_hackathon_empathy_start_training_lambda_security_group_name		= "cl-ir-hackathon-empathy-start-training-lambda"
  cl_ir_hackathon_empathy_start_training_lambda_role_name			= "cl-ir-hackathon-empathy-start-training-lambda"
  cl_ir_hackathon_empathy_start_training_lambda_role_policy_name		= "cl-ir-hackathon-empathy-start-training-lambda"
  cl_ir_hackathon_empathy_codepipeline_name					= "cl-ir-ml-hackathon-mlops"

  # CxLink Hackathon Empathy AWS Forecast Query Lambda Values

  cl_ir_ml_hackathon_forecast_query_lambda_ecr_repo			= "cl-ir-ml-hackathon-forecast-query-lambda"

  cl_ir_ml_hackathon_forecast_query_lambda_test_mode			= "False"
  cl_ir_ml_hackathon_forecast_query_lambda_function_name		= "cl-ir-ml-hackathon-forecast-query"
  cl_ir_ml_hackathon_forecast_query_lambda_image_tag			= "cl_ir_ml_hackathon_forecast_query_v1.0"
  cl_ir_ml_hackathon_forecast_query_lambda_sqs_dlq_name			= "cl-ir-ml-hackathon-forecast-query-dql"

  cl_ir_ml_hackathon_forecast_query_lambda_sqs_dlq_delay		= 90
  cl_ir_ml_hackathon_forecast_query_lambda_sqs_dlq_max_size		= 2048
  cl_ir_ml_hackathon_forecast_query_lambda_sqs_dlq_retention		= 86400
  cl_ir_ml_hackathon_forecast_query_lambda_sqs_dlq_wait_time		= 10

  cl_ir_ml_hackathon_forecast_query_lambda_function_publish_enabled	= true
  cl_ir_ml_hackathon_forecast_query_lambda_function_concurrency		= -1
  cl_ir_ml_hackathon_forecast_query_lambda_tracing_mode			= "PassThrough"
  cl_ir_ml_hackathon_forecast_query_lambda_function_ephemeral_size	= 512
  cl_ir_ml_hackathon_forecast_query_lambda_subnet_ids			= var.private_subnet_ids
  cl_ir_ml_hackathon_forecast_query_lambda_sns_topic_name		= "cl-ir-ml-hackathon_forecast-query-lambda"
  cl_ir_ml_hackathon_forecast_query_lambda_handler			= "cl-ir-ml-hackathon_forecast-query-lambda-handler.lambda_handler"
  cl_ir_ml_hackathon_forecast_query_lambda_runtime			= "python3.8"
  cl_ir_ml_hackathon_forecast_query_lambda_timeout			= 900
  cl_ir_ml_hackathon_forecast_query_lambda_package_type			= "Image"
  cl_ir_ml_hackathon_forecast_query_lambda_memory			= 512
  cl_ir_ml_hackathon_forecast_query_lambda_description			= "CxLink AWS Forecast QueryForecast Lambda"
  cl_ir_ml_hackathon_forecast_query_lambda_alias_name			= "cl-ir-ml-hackathon-forecast-query-lambda"
  cl_ir_ml_hackathon_forecast_query_lambda_alias_description		= "CxLink AWS Forecast QueryForecast Lambda"
  cl_ir_ml_hackathon_forecast_query_lambda_security_group_name		= "cl-ir-ml-hackathon-forecast-query-lambda"
  cl_ir_ml_hackathon_forecast_query_lambda_role_name			= "cl-ir-ml-hackathon-forecast-query-lambda"
  cl_ir_ml_hackathon_forecast_query_lambda_role_policy_name		= "cl-ir-ml-hackathon-forecast-query-lambda"
  cl_ir_ml_hackathon_forecast_dataset_group_name			= "cl_ir_hackathon_erus_cruz_roja"
  cl_ir_ml_hackathon_forecast_use_case					= "work_force" 

  # CxLink Hackathon Empathy Audio Lambda Values

  cl_ir_hackathon_empathy_audio_lambda_ecr_repo			= "cl-ir-hackathon-empathy-audio-lambda"

  cl_ir_hackathon_empathy_audio_lambda_function_name			= "cl-ir-hackathon-empathy-audio"
  cl_ir_hackathon_empathy_audio_lambda_image_tag			= "cl_ir_hackathon_empathy_audio_v1.0"
  cl_ir_hackathon_empathy_audio_lambda_sqs_dlq_name			= "cl-ir-hackathon-empathy-audio-dql"

  cl_ir_hackathon_empathy_audio_lambda_sqs_dlq_delay			= 90
  cl_ir_hackathon_empathy_audio_lambda_sqs_dlq_max_size		= 2048
  cl_ir_hackathon_empathy_audio_lambda_sqs_dlq_retention		= 86400
  cl_ir_hackathon_empathy_audio_lambda_sqs_dlq_wait_time		= 10

  cl_ir_hackathon_empathy_audio_lambda_function_publish_enabled	= true
  cl_ir_hackathon_empathy_audio_lambda_function_concurrency		= -1
  cl_ir_hackathon_empathy_audio_lambda_tracing_mode			= "PassThrough"
  cl_ir_hackathon_empathy_audio_lambda_function_ephemeral_size	= 512
  cl_ir_hackathon_empathy_audio_lambda_subnet_ids			= var.private_subnet_ids
  cl_ir_hackathon_empathy_audio_lambda_sns_topic_name			= "cl-ir-hackathon-empathy-audio-lambda"
  cl_ir_hackathon_empathy_audio_lambda_handler			= "cl-ir-hackathon-empathy-audio-lambda-handler.lambda_handler"
  cl_ir_hackathon_empathy_audio_lambda_runtime			= "go.1"
  cl_ir_hackathon_empathy_audio_lambda_timeout			= 900
  cl_ir_hackathon_empathy_audio_lambda_package_type			= "Image"
  cl_ir_hackathon_empathy_audio_lambda_memory				= 512
  cl_ir_hackathon_empathy_audio_lambda_description			= "CxLink Hackathon Empathy audio Lambda"
  cl_ir_hackathon_empathy_audio_lambda_alias_name			= "cl-ir-hackathon-empathy-audio-lambda"
  cl_ir_hackathon_empathy_audio_lambda_alias_description		= "CxLink Hackathon Empathy audio Lambda"
  cl_ir_hackathon_empathy_audio_lambda_security_group_name		= "cl-ir-hackathon-empathy-audio-lambda"
  cl_ir_hackathon_empathy_audio_lambda_role_name			= "cl-ir-hackathon-empathy-audio-lambda"
  cl_ir_hackathon_empathy_audio_lambda_role_policy_name		= "cl-ir-hackathon-empathy-audio-lambda"


  # CxLink Hackathon Empathy Text Lambda Values

  cl_ir_hackathon_empathy_text_lambda_ecr_repo                 = "cl-ir-hackathon-empathy-text-lambda"
  cl_ir_hackathon_empathy_text_lambda_function_name                    = "cl-ir-hackathon-empathy-text"
  cl_ir_hackathon_empathy_text_lambda_image_tag                        = "cl_ir_hackathon_empathy_text_v1.0"
  cl_ir_hackathon_empathy_text_lambda_sqs_dlq_name                     = "cl-ir-hackathon-empathy-text-dql"

  cl_ir_hackathon_empathy_text_lambda_sqs_dlq_delay                    = 90
  cl_ir_hackathon_empathy_text_lambda_sqs_dlq_max_size         = 2048
  cl_ir_hackathon_empathy_text_lambda_sqs_dlq_retention                = 86400
  cl_ir_hackathon_empathy_text_lambda_sqs_dlq_wait_time                = 10

  cl_ir_hackathon_empathy_text_lambda_function_publish_enabled = true
  cl_ir_hackathon_empathy_text_lambda_function_concurrency             = -1
  cl_ir_hackathon_empathy_text_lambda_tracing_mode                     = "PassThrough"
  cl_ir_hackathon_empathy_text_lambda_function_ephemeral_size  = 512
  cl_ir_hackathon_empathy_text_lambda_subnet_ids                       = var.private_subnet_ids
  cl_ir_hackathon_empathy_text_lambda_sns_topic_name                   = "cl-ir-hackathon-empathy-text-lambda"
  cl_ir_hackathon_empathy_text_lambda_handler                  = "cl-ir-hackathon-empathy-text-lambda-handler.lambda_handler"
  cl_ir_hackathon_empathy_text_lambda_runtime                  = "go.1"
  cl_ir_hackathon_empathy_text_lambda_timeout                  = 900
  cl_ir_hackathon_empathy_text_lambda_package_type                     = "Image"
  cl_ir_hackathon_empathy_text_lambda_memory                           = 512
  cl_ir_hackathon_empathy_text_lambda_description                      = "CxLink Hackathon Empathy text Lambda"
  cl_ir_hackathon_empathy_text_lambda_alias_name                       = "cl-ir-hackathon-empathy-text-lambda"
  cl_ir_hackathon_empathy_text_lambda_alias_description                = "CxLink Hackathon Empathy text Lambda"
  cl_ir_hackathon_empathy_text_lambda_security_group_name              = "cl-ir-hackathon-empathy-text-lambda"
  cl_ir_hackathon_empathy_text_lambda_role_name                        = "cl-ir-hackathon-empathy-text-lambda"
  cl_ir_hackathon_empathy_text_lambda_role_policy_name         = "cl-ir-hackathon-empathy-text-lambda"

}
