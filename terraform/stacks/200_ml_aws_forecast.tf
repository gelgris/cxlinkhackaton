module "ml_aws_forecast" {

  source  = "../../terraform/modules/ml/aws-forecast"

  owner					= var.owner
  project				= var.project
  region   				= var.region
  vpc_id				= var.vpc_id
  default_profile			= var.default_profile
  stage					= var.stage
  prefix				= var.prefix

  # Global KMS Values

  cl_ir_ecr_kms_key_id						= var.cl_ir_ecr_kms_key_id
  cl_ir_cloudwatch_kms_key_id					= var.cl_ir_cloudwatch_kms_key_id
  cl_ir_lambda_kms_key_id					= var.cl_ir_lambda_kms_key_id
  cl_ir_s3_kms_key_id						= var.cl_ir_s3_kms_key_id

  # Not used

  cl_awseservedSSO_administratorAccess_role			= ""
  cl_awseservedSSO_security_team_role				= ""

  cl_ir_ml_hackathon_aws_forecast_target_datasets_files                            = fileset(path.module, "templates/forecast/datasets/*target_dataset.{yml,yaml}")
  cl_ir_ml_hackathon_aws_forecast_related_datasets_files                           = fileset(path.module, "templates/forecast/datasets/*related_dataset.{yml,yaml}")
  cl_ir_ml_hackathon_aws_forecast_customers_files                                  = fileset(path.module, "templates/forecast/customers/*.{yml,yaml}")

  # Lambda Values

  cl_ir_hackathon_empathy_extract_lambda_function_name		= "cl-ir-hackathon-empathy-extract"
  cl_ir_hackathon_empathy_filter_lambda_function_name		= "cl-ir-hackathon-empathy-filter"
  cl_ir_hackathon_empathy_audio_lambda_function_name = "cl-ir-hackathon-empathy-audio"
  cl_ir_hackathon_empathy_text_lambda_function_name = "cl-ir-hackathon-empathy-text"

  # CxLink Raw (Submissions) DataLake S3 Bucket

  cl_ir_ml_hackathon_aws_forecast_raw_bucket_lifecycle_archive_rule_name           = "cl-ir-ml-aws-forecast-raw-bucket-rule"
  cl_ir_ml_hackathon_aws_forecast_raw_bucket_lifecycle_glacier_rule_filter_key     = ""
  cl_ir_ml_hackathon_aws_forecast_raw_bucket_lifecycle_glacier_rule_filter_value   = ""
  cl_ir_ml_hackathon_aws_forecast_raw_bucket_lifecycle_archive_rule_glacier_days   = 90
  cl_ir_ml_hackathon_aws_forecast_raw_bucket_lifecycle_archive_rule_deep_days      = 180

  cl_ir_ml_hackathon_aws_forecast_raw_bucket_notification_filter_prefix	      		= "text/"
  cl_ir_ml_hackathon_aws_forecast_raw_bucket_notification_filter_suffix	      		= ".txt" 


  cl_ir_ml_hackathon_filter_lambda_aws_forecast_raw_bucket_notification_filter_prefix	= "comprehend/"
  cl_ir_ml_hackathon_filter_lambda_aws_forecast_raw_bucket_notification_filter_suffix	= ".tar.gz"

  cl_ir_ml_hackathon_audio_lambda_aws_forecast_raw_bucket_notification_filter_prefix	= "audio/"
  cl_ir_ml_hackathon_audio_lambda_aws_forecast_raw_bucket_notification_filter_suffix	= ".wav"

  cl_ir_ml_hackathon_text_lambda_aws_forecast_raw_bucket_notification_filter_prefix	= "transcribe/"
  cl_ir_ml_hackathon_text_lambda_aws_forecast_raw_bucket_notification_filter_suffix	= ".json"

  # CxLink Curated DataLake S3 Bucket

  cl_ir_ml_hackathon_aws_forecast_curated_bucket_lifecycle_archive_rule_name           = "cl-ir-ml-aws-forecast-curated-bucket-rule"
  cl_ir_ml_hackathon_aws_forecast_curated_bucket_lifecycle_glacier_rule_filter_key     = ""
  cl_ir_ml_hackathon_aws_forecast_curated_bucket_lifecycle_glacier_rule_filter_value   = ""
  cl_ir_ml_hackathon_aws_forecast_curated_bucket_lifecycle_archive_rule_glacier_days   = 90
  cl_ir_ml_hackathon_aws_forecast_curated_bucket_lifecycle_archive_rule_deep_days      = 180

  # CxLink AWS Forecast Secrets

  cl_ir_ml_hackathon_aws_forecast_api_secret_name				= "cl-ir-ml-aws-forecast-api-credentials"
  cl_ir_ml_hackathon_aws_forecast_api_secret_value				= "{\"user\":\"TODO\",\"password\":\"TODO\"}"

  # CxLink AWS Forecasting Work Force DataSet Values

  cl_ir_ml_hackathon_aws_forecast_role_name		= "cl-ir-ml-aws-forecast-ir"
  cl_ir_ml_hackathon_aws_forecast_role_policy_name	= "cl-ir-ml-aws-forecast-ip"
  cl_ir_ml_hackathon_aws_forecast_work_force_dataset_domain		= "WORK_FORCE"
  cl_ir_ml_hackathon_aws_forecast_work_force_dataset_format		= "CSV"
  cl_ir_ml_hackathon_aws_forecast_work_force_dataset_timezone		= "Europe/Madrid" # https://joda-time.sourceforge.net/timezones.html
  cl_ir_ml_hackathon_aws_forecast_work_force_dataset_use_geolocation	= "False"
  cl_ir_ml_hackathon_aws_forecast_work_force_dataset_geolocation		= "LAT_LONG"

  cl_ir_ml_hackathon_aws_forecast_work_force_dataset_target_name		= "cl_ir_ml_hackathon_aws_forecast_sales_target"
  cl_ir_ml_hackathon_aws_forecast_work_force_dataset_target_frecuency		= "H"
  cl_ir_ml_hackathon_aws_forecast_work_force_dataset_target_type		= "TARGET_TIME_SERIES"

  cl_ir_ml_hackathon_aws_forecast_work_force_dataset_related_name		= "cl_ir_ml_hackathon_aws_forecast_sales_related"
  cl_ir_ml_hackathon_aws_forecast_work_force_dataset_related_frecuency	= "H"
  cl_ir_ml_hackathon_aws_forecast_work_force_dataset_related_type		= "RELATED_TIME_SERIES"

  cl_ir_ml_hackathon_aws_forecast_work_force_dataset_item_metadata_name		= "cl_ir_ml_hackathon_aws_forecast_sales_item_metadata"
  cl_ir_ml_hackathon_aws_forecast_work_force_dataset_item_metadata_frecuency	= "H"
  cl_ir_ml_hackathon_aws_forecast_work_force_dataset_item_metadata_type		= "ITEM_METADATA"

  cl_ir_ml_hackathon_aws_forecast_work_force_dataset_group_name			= "cl_ir_ml_hackathon_aws_forecast_sales"
}
