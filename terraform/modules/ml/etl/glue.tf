resource "aws_glue_catalog_database" "cl_ir_ml_hackathon_ea_database" {
  provider = aws.account-742189430206-eu-west-1

  catalog_id = data.aws_caller_identity.current.account_id
  name = format("${var.cl_ir_ml_hackathon_ea_glue_database_name}-%s",local.environment[terraform.workspace])
  description = "CxLink Hackathon Empathy Assistant Glue Database"
}

resource "aws_glue_security_configuration" "cl_ir_ml_hackathon_ea_etl_glue_security_config" {
  provider = aws.account-742189430206-eu-west-1

  name = format("${var.cl_ir_ml_hackathon_ea_etl_glue_security_config_name}-%s",local.environment[terraform.workspace])

  encryption_configuration {
    cloudwatch_encryption {
      cloudwatch_encryption_mode = var.cl_ir_ml_hackathon_ea_etl_glue_security_config_cloudwatch_encryption
      kms_key_arn = "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_cloudwatch_kms_key_id}"
    }

    job_bookmarks_encryption {
      job_bookmarks_encryption_mode = var.cl_ir_ml_hackathon_ea_etl_glue_security_config_job_bookmarks_encryption
      kms_key_arn = "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_glue_kms_key_id}"
    }

    s3_encryption {
      kms_key_arn        = "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_s3_kms_key_id}"
      s3_encryption_mode = "SSE-KMS"
    }
  }
}

resource "aws_glue_crawler" "cl_ir_ml_hackathon_ea_etl_glue_crawler" {
  provider = aws.account-742189430206-eu-west-1

  database_name = aws_glue_catalog_database.cl_ir_ml_hackathon_ea_database.name
  name          = format("${var.cl_ir_ml_hackathon_ea_etl_glue_crawler_name}-%s",local.environment[terraform.workspace])
  description   = "CxLink Hackathon Empathy Assistant Glue Crawler"
  role          = aws_iam_role.cl_ir_ml_hackathon_ea_glue_crawler_role.arn
  schedule      = var.cl_ir_ml_hackathon_ea_etl_glue_crawler_schedule

  s3_target {
    path = "s3://${format("${var.cl_ir_ml_hackathon_aws_forecast_raw_bucket_name}-%s",local.environment[terraform.workspace])}/${var.cl_ir_ml_hackathon_datalake_account_id}/${var.region}/aws-forecast/${var.cl_ir_ml_hackathon_ea_use_case}/"
    exclusions = var.cl_ir_ml_hackathon_ea_etl_glue_crawler_exclusions
  }

  configuration = jsonencode(
    {
      Grouping = {
        TableLevelConfiguration = 6
      }
      Version = 1
    }
  )

  schema_change_policy {
    delete_behavior = var.cl_ir_ml_hackathon_ea_etl_glue_crawler_deletes_schema_change_policy
    update_behavior = var.cl_ir_ml_hackathon_ea_etl_glue_crawler_updates_schema_change_policy
  }

  # Enable this when the DataLake S3 buckets will be in a differents AWS Account (i.e. DataLake AWS Account)

  lake_formation_configuration {
    account_id = data.aws_caller_identity.current.account_id
    use_lake_formation_credentials = false
  }

  lineage_configuration {
    crawler_lineage_settings = var.cl_ir_ml_hackathon_ea_etl_glue_crawler_lineage_configuration
  }

  recrawl_policy {
    recrawl_behavior = var.cl_ir_ml_hackathon_ea_etl_glue_crawler_recrawl_policy
  }

  security_configuration = aws_glue_security_configuration.cl_ir_ml_hackathon_ea_etl_glue_security_config.name
  tags = local.tags
}
