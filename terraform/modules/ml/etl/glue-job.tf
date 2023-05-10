# TODO: Maybe enable this

#resource "aws_glue_trigger" "cl_ir_ml_hackathon_ea_glue_job_trigger" {
#  name 			= format("${var.cl_ir_ml_hackathon_ea_glue_job_trigger_name}-%s",local.environment[terraform.workspace])
#  enabled 		= var.cl_ir_ml_hackathon_ea_glue_job_trigger_enabled
#  type 			= var.cl_ir_ml_hackathon_ea_glue_job_trigger_type
  # schedule 		= var.cl_ir_ml_hackathon_ea_glue_job_trigger_scheduling
#  start_on_creation 	= false
  #workflow_name 	=

  # We will execute the AWS Forecast ETL Glue Job when the AWS Forecast Crawler has finished

#  actions {
#    job_name 			= aws_glue_job.cl_ir_ml_hackathon_ea_glue_job.name
#    timeout  			= var.cl_ir_ml_hackathon_ea_glue_job_trigger_timeout
#    security_configuration	= aws_glue_security_configuration.cl_ir_ml_hackathon_ea_etl_glue_security_config.name
#    notification_property {
#      notify_delay_after = var.cl_ir_ml_hackathon_ea_glue_job_trigger_delay
#    }
#  }

  # In a conditional Glue Job, we will watch another Glue Job or
  # a specific Crawler.

#  predicate {
#    conditions {
#      crawler_name 	= aws_glue_crawler.cl_ir_ml_hackathon_ea_etl_glue_crawler.name
#      logical_operator  = "EQUALS"
#      crawl_state       = "SUCCEEDED"
#    }
#  }
#  tags 			= local.tags
#}

resource "aws_cloudwatch_log_group" "cl_ir_ml_hackathon_ea_glue_job_log_group" {
  provider = aws.account-742189430206-eu-west-1

  name 		    = format("/aws/glue/aws-forecast/jobs/%s-%s",var.cl_ir_ml_hackathon_ea_glue_job_name,local.environment[terraform.workspace])
  skip_destroy 	    = false
  retention_in_days = var.cl_ir_ml_hackathon_ea_glue_job_log_group_retention
  kms_key_id	    = "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_cloudwatch_kms_key_id}"
  tags 		    = local.tags
}

resource "aws_glue_job" "cl_ir_ml_hackathon_ea_glue_job" {
  provider = aws.account-742189430206-eu-west-1

  name                      = format("${var.cl_ir_ml_hackathon_ea_glue_job_name}-%s",local.environment[terraform.workspace])
  description               = format("${var.cl_ir_ml_hackathon_ea_glue_job_description} in the %s environment",local.environment[terraform.workspace])
  connections               = var.cl_ir_ml_hackathon_ea_glue_job_connections
  default_arguments         = {

	    "--scriptLocation" : "s3://${aws_s3_bucket.cl_ir_ml_hackathon_ea_glue_bucket.id}/${data.aws_caller_identity.current.account_id}/${var.region}/aws-forecast/${var.cl_ir_ml_hackathon_ea_use_case}/etls/gluejobs/${var.cl_ir_ml_hackathon_ea_glue_job_name}/main.py",
            "--extra-files" : "s3://${aws_s3_bucket.cl_ir_ml_hackathon_ea_glue_bucket.id}/${data.aws_caller_identity.current.account_id}/${var.region}/aws-forecast/${var.cl_ir_ml_hackathon_ea_use_case}/etls/gluejobs/${var.cl_ir_ml_hackathon_ea_glue_job_name}/${var.cl_ir_ml_hackathon_ea_glue_job_extra_files}",
            "--job-language": "${var.cl_ir_ml_hackathon_ea_glue_job_language}",
            "--spark-event-logs-path": "s3://${aws_s3_bucket.cl_ir_ml_hackathon_ea_glue_bucket.id}/${var.cl_ir_ml_hackathon_ea_glue_job_spark_event_logs}",
            "--enable-metrics": "${var.cl_ir_ml_hackathon_ea_glue_job_enable_metrics}",
            "--enable-spark-ui": "${var.cl_ir_ml_hackathon_ea_glue_job_enable_spark_ui}",
            "--TempDir": "s3://${aws_s3_bucket.cl_ir_ml_hackathon_ea_glue_bucket.id}/${var.cl_ir_ml_hackathon_ea_glue_job_tempdir}",
            "--enable-auto-scaling" : "${var.cl_ir_ml_hackathon_ea_glue_job_enable_autoscaling}",
            "--enable-job-insights": "${var.cl_ir_ml_hackathon_ea_glue_job_enable_job_insights}",
            "--enable-glue-datacatalog": "${var.cl_ir_ml_hackathon_ea_glue_job_enable_datacatalog}",
	    "--use-postgres-driver" : "${var.cl_ir_ml_hackathon_ea_glue_job_use_postgres_driver}"
            "--job-bookmark-option": "${var.cl_ir_ml_hackathon_ea_glue_job_bookmark_option}",
            "--enable-continuous-cloudwatch-log": "${var.cl_ir_ml_hackathon_ea_glue_job_enable_continuous_cloudwatch_log}",
	    "--continuous-log-logGroup" : format("/aws/glue/aws-forecast/jobs/%s-%s",var.cl_ir_ml_hackathon_ea_glue_job_name,local.environment[terraform.workspace]),
	    "--continuous-log-logStreamPrefix" : "aws-forecast",
	    "--aws_account" : "${data.aws_caller_identity.current.account_id}",
            "--aws_region" : "${var.region}",
            "--environment" : "${local.environment[terraform.workspace]}",
            "--aws_forecast_glue_database_name" : aws_glue_catalog_database.cl_ir_ml_hackathon_ea_database.name,
            "--aws_forecast_glue_table_name" : "${var.cl_ir_ml_hackathon_ea_glue_table_name}",
            "--aws_forecast_use_case" : "${var.cl_ir_ml_hackathon_ea_use_case}",
            "--aws_forecast_curated_s3_bucket" : format("${var.cl_ir_ml_hackathon_ea_curated_bucket_name}-%s",local.environment[terraform.workspace]),
            "--aws_forecast_glue_job_output_format" : "${var.cl_ir_ml_hackathon_ea_glue_job_output_format}",
            "--mappings_file" : "mappings.json"
  }

  non_overridable_arguments = var.cl_ir_ml_hackathon_ea_glue_job_non_overridable_arguments
  glue_version              = var.cl_ir_ml_hackathon_ea_glue_job_glue_version
  timeout                   = var.cl_ir_ml_hackathon_ea_glue_job_timeout

  # Only for glueetl and gluestreaming glue job types

  number_of_workers         = var.cl_ir_ml_hackathon_ea_glue_job_number_of_workers
  worker_type               = var.cl_ir_ml_hackathon_ea_glue_job_worker_type

  # For pythonshell we need max_capacity

  #max_capacity              = var.cl_ir_ml_hackathon_ea_glue_job_max_capacity
  role_arn                  = aws_iam_role.cl_ir_ml_hackathon_ea_glue_job_role.arn
  security_configuration    = aws_glue_security_configuration.cl_ir_ml_hackathon_ea_etl_glue_security_config.id
  max_retries               = var.cl_ir_ml_hackathon_ea_glue_job_max_retries

  command {
    name            = try(var.cl_ir_ml_hackathon_ea_glue_job_command_name, null)
    python_version  = try(var.cl_ir_ml_hackathon_ea_glue_job_command_python_version, null)
    script_location = "s3://${aws_s3_bucket.cl_ir_ml_hackathon_ea_glue_bucket.id}/${data.aws_caller_identity.current.account_id}/${var.region}/aws-forecast/${var.cl_ir_ml_hackathon_ea_use_case}/etls/gluejobs/${var.cl_ir_ml_hackathon_ea_glue_job_name}/main.py"
  }

  #dynamic "notification_property" {
  #  for_each = var.notification_property != null ? [true] : []
  #  content {
  #    notify_delay_after = var.notification_property.notify_delay_after
  #  }
  #}

  #dynamic "execution_property" {
  #  for_each = var.execution_property != null ? [true] : []
  #  content {
  #    max_concurrent_runs = var.execution_property.max_concurrent_runs
  #  }
  #}

  tags = local.tags
}
