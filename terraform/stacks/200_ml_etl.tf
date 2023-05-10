module "cl_hackathon_ea_etl" {

  source  = "../../terraform/modules/ml/etl"

  providers = {
            aws.account-585543526779-eu-west-1 = aws.account-585543526779-eu-west-1,
            aws.account-742189430206-eu-west-1 = aws.account-742189430206-eu-west-1
  }

  owner                                 = var.owner
  project                               = var.project
  region                                = var.region
  vpc_id                                = var.vpc_id
  default_profile                       = var.default_profile
  stage                                 = var.stage
  prefix                                = var.prefix

  # Global KMS Values

  cl_ir_ecr_kms_key_id                                          = "05c3a42a-0061-46fb-9ae4-004a4206a2dd"
  cl_ir_cloudwatch_kms_key_id                                   = "5f3096b7-00aa-4fdf-813c-5730cb81bd56"
  cl_ir_lambda_kms_key_id                                       = "4abc900d-4d98-4e4e-bfa7-699eea4a6c5d"
  cl_ir_s3_kms_key_id                                           = "1b9ce158-7922-4ac3-ad7c-0890de8e51bd"
  cl_ir_glue_kms_key_id                                         = "276beac9-66c4-44cb-9c2f-7215b60cc91d"
  cl_ir_ml_hackathon_ea_use_case				= "work-force"

  # Glue Values

  cl_ir_ml_hackathon_ea_etl_glue_security_config_name				= "cl-ir-ml-hackathon-ea-glue-security-config"
  cl_ir_ml_hackathon_ea_etl_glue_security_config_cloudwatch_encryption		= "SSE-KMS"
  cl_ir_ml_hackathon_ea_etl_glue_security_config_job_bookmarks_encryption	= "CSE-KMS"

  cl_ir_ml_hackathon_ea_glue_database_name		 			= "cl-ir-ml-hackathon-ea-glue"
  cl_ir_ml_hackathon_ea_glue_table_name						= "work_force"
  cl_ir_ml_hackathon_ea_glue_crawler_role_name					= "cl-ir-ml-hackathon-ea-glue-ir"
  cl_ir_ml_hackathon_ea_glue_crawler_role_policy_name				= "cl-ir-ml-hackathon-ea-glue-ip"
  cl_ir_ml_hackathon_ea_etl_glue_crawler_name					= "cl-ir-ml-hackathon-ea-glue-crawler"

  cl_ir_ml_hackathon_ea_etl_glue_crawler_schedule			= "cron(15 12 * * ? *)"
  cl_ir_ml_hackathon_ea_etl_glue_crawler_deletes_schema_change_policy	= "DELETE_FROM_DATABASE"
  cl_ir_ml_hackathon_ea_etl_glue_crawler_updates_schema_change_policy	= "UPDATE_IN_DATABASE"
  cl_ir_ml_hackathon_ea_etl_glue_crawler_lineage_configuration		= "DISABLE"
  cl_ir_ml_hackathon_ea_etl_glue_crawler_recrawl_policy			= "CRAWL_EVERYTHING"
  cl_ir_ml_hackathon_ea_etl_glue_crawler_exclusions			= ["cl_ir_ml_hackathon_ea_import*", "MARD/*", "VBAP/*"]

  # Glue Trigger Values

  cl_ir_ml_hackathon_ea_glue_job_trigger_name				= "cl-ir-ml-hackathon-ea-glue-job-trigger"
  cl_ir_ml_hackathon_ea_glue_job_trigger_enabled			= false
  cl_ir_ml_hackathon_ea_glue_job_trigger_type				= "CONDITIONAL"	# ON_DEMAND, SCHEDULED or CONDITIONAL
  cl_ir_ml_hackathon_ea_glue_job_trigger_scheduling			= "cron(15 12 * * ? *)"
  cl_ir_ml_hackathon_ea_glue_job_trigger_timeout			= 10	# Minutes
  cl_ir_ml_hackathon_ea_glue_job_trigger_delay				= 1

  # Glue Job Values

  cl_ir_ml_hackathon_ea_glue_job_name					= "cl-ir-ml-hackathon-ea-datasets-transformation"
  cl_ir_ml_hackathon_ea_glue_job_description				= "Syntax AWS Forecast DataSets Transformation Glue Job"
  cl_ir_ml_hackathon_ea_glue_job_connections				= []
  cl_ir_ml_hackathon_ea_glue_job_tempdir				= "tempdir"
  cl_ir_ml_hackathon_ea_glue_job_python_mods_install_options		= ""
  cl_ir_ml_hackathon_ea_glue_job_disable_proxy				= "false"
  cl_ir_ml_hackathon_ea_glue_job_enable_autoscaling			= "false"
  cl_ir_ml_hackathon_ea_glue_job_enable_metrics				= "true"
  cl_ir_ml_hackathon_ea_glue_job_enable_spark_ui			= "true"
  cl_ir_ml_hackathon_ea_glue_job_python_modules				= ""
  cl_ir_ml_hackathon_ea_glue_job_spark_event_logs			= "sparkHistoryLogs/"
  cl_ir_ml_hackathon_ea_glue_job_enable_job_insights			= "true"
  cl_ir_ml_hackathon_ea_glue_job_enable_datacatalog			= "true"
  cl_ir_ml_hackathon_ea_glue_job_use_postgres_driver			= "false"
  cl_ir_ml_hackathon_ea_glue_job_bookmark_option			= "job-bookmark-enable"
  cl_ir_ml_hackathon_ea_glue_job_enable_continuous_cloudwatch_log	= "true"
  cl_ir_ml_hackathon_ea_glue_job_extra_files				= "mappings.json"
  cl_ir_ml_hackathon_ea_glue_job_datalake_formats			= "" # "hudi,delta,iceberg"
  cl_ir_ml_hackathon_ea_glue_job_log_group_name				= "/aws/glue/jobs/"
  cl_ir_ml_hackathon_ea_glue_job_log_group_retention			= 14
  cl_ir_ml_hackathon_ea_glue_job_non_overridable_arguments		= {}
  cl_ir_ml_hackathon_ea_glue_job_glue_version				= "3.0"
  cl_ir_ml_hackathon_ea_glue_job_timeout				= 300
  cl_ir_ml_hackathon_ea_glue_job_number_of_workers			= 10
  cl_ir_ml_hackathon_ea_glue_job_worker_type				= "G.1X"
  cl_ir_ml_hackathon_ea_glue_job_max_capacity				= 10.0
  cl_ir_ml_hackathon_ea_glue_job_max_retries				= 0
  cl_ir_ml_hackathon_ea_glue_job_command_name				= "glueetl" # pythonshell, glueetl or gluestreaming
  cl_ir_ml_hackathon_ea_glue_job_command_python_version			= "3"
  cl_ir_ml_hackathon_ea_glue_job_role_name				= "cl-ir-ml-hackathon-ea-glue-job-ir"
  cl_ir_ml_hackathon_ea_glue_job_role_policy_name			= "cl-ir-ml-hackathon-ea-glue-job-ip"
  cl_ir_ml_hackathon_ea_glue_job_language				= "python"
  cl_ir_ml_hackathon_ea_glue_job_output_format				= "csv"

  # Syntax AWS Forecasting DataLake S3 Buckets

  cl_ir_ml_hackathon_datalake_account_id				= "585543526779"
  cl_ir_ml_hackathon_ea_glue_bucket_name                     		= "cl-ir-ml-hackathon-ea-glue-forecast-bucket"
  cl_ir_ml_hackathon_ea_raw_bucket_name					= "cl-ir-ml-hackathon-aws-forecast-raw-bucket-cruz-roja"
  cl_ir_ml_hackathon_ea_curated_bucket_name				= "cl-ir-ml-hackathon-aws-forecast-curated-bucket-cruz-roja"
  cl_ir_ml_hackathon_aws_forecast_raw_bucket_name			= "cl-hackathon-aws-forecast-raw-bucket-cruz-roja"
  cl_ir_ml_hackathon_aws_forecast_curated_bucket_name			= "cl-hackathon-aws-forecast-curated-bucket-cruz-roja"
}
