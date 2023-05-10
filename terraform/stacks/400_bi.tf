module "empathy_bi_quicksight" {
  source  = "../../terraform/modules/bi/quicksight"

  providers = {
            aws.account-585543526779-eu-west-1 = aws.account-585543526779-eu-west-1,
            aws.account-742189430206-eu-west-1 = aws.account-742189430206-eu-west-1
  }

  owner                                 = var.owner
  project                               = var.project
  region                                = var.region
  vpc_id                                = var.vpc_id
  stage                                 = var.stage
  prefix                                = var.prefix

  cl_ir_s3_kms_key_id			= "1b9ce158-7922-4ac3-ad7c-0890de8e51bd"

  # S3 DataLake Values

  cl_ir_ml_hackathon_aws_forecast_raw_bucket_name		= "cl-ir-ml-hackathon-aws-forecast-raw-bucket-cruz-roja"
  cl_ir_ml_hackathon_aws_forecast_curated_bucket_name		= "cl-ir-ml-hackathon-aws-forecast-curated-bucket-cruz-roja"
  cl_ir_ml_hackathon_empathy_quicksight_bucket_name   		= "cl-ir-ml-hackathon-empathy-quicksight"

  # Athena DataSource Values

  cl_ir_ml_hackathon_empathy_quicksight_athena_wg_name			= "cl-ir-hackathon-quicksigh-athena-ds"
  cl_ir_ml_hackathon_empathy_quicksight_athena_wg_enforcing_enabled		= true
  cl_ir_ml_hackathon_empathy_quicksight_athena_wg_cloudwatch_metrics_enabled	= true

  # Quicksight Subscription

  cl_ir_ml_hackathon_empathy_quicksight_account_name		  = "cxlink-empathy"
  cl_ir_ml_hackathon_empathy_quicksight_authentication_method	  = "IAM_AND_QUICKSIGHT"
  cl_ir_ml_hackathon_empathy_quicksight_edition		  	  = "ENTERPRISE"
  cl_ir_ml_hackathon_empathy_quicksight_notification_email 	  = "daniel.soto@syntax.com"
  cl_ir_ml_hackathon_empathy_quicksight_secret_password_length    = 10
  cl_ir_ml_hackathon_empathy_quicksight_secret_name		  = "cl-ir-hackathon-quicksight"

  # Quicksight User and Groups

  cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_group_name		= "cl-ir-hackathon-quicksight-s3"
  cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_group_description	= "CxLink Hackathon Empathy Assitant Quicksight S3 DataSource Group"

  # This user is mapped to an IAM user and you should give console access him and set a password
  # Then, Quicksight will redirect you in the login to the AWS Console
  # Th e user MUST have AUTHOR role to create DataSources and other assets.

  cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_author_user_role          = "AUTHOR"
  cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_author_user_name	   	= "cl-ir-hackathon-quicksight-author"
  cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_author_user_session_name  = "cl-ir-hackathon-quicksight-author"
  cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_author_user_email	   	= "daniel.soto@syntax.com"

  cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_author_user_policy_name   = "cl-ir-hackathon-quicksight-author"

  cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_admin_user_role           = "ADMIN"
  cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_admin_user_name	   	= "cl-ir-hackathon-quicksight-admin"
  cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_admin_user_session_name   = "cl-ir-hackathon-quicksight-admin"
  cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_admin_user_email	  	= "daniel.soto@syntax.com"

  cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_admin_user_policy_name    = "cl-ir-hackathon-quicksight-admin"

  cl_ir_ml_hackathon_empathy_quicksight_role_name				= "cl-ir-ml-hackathon-empathy-quicksight"
  cl_ir_ml_hackathon_empathy_quicksight_role_policy_name			= "cl-ir-ml-hackathon-empathy-quicksight"

  # Quicksight DataSources

  cl_ir_ml_hackathon_empathy_quicksight_s3_datasource_name			= "cl-ir-hackathon-quicksight-s3-ds"
  cl_ir_ml_hackathon_empathy_quicksight_s3_datasource_description		= "CxLink Hackathon Empathy Assitant Quicksight DataSource"
  cl_ir_ml_hackathon_empathy_quicksight_s3_datasource_username			= "cl-ir-hackathon-quicksight-ds"
  cl_ir_ml_hackathon_empathy_quicksight_s3_datasource_s3_manifest_key		= "cl-ir-hackathon-quicksight-s3-ds"
  cl_ir_ml_hackathon_empathy_quicksight_s3_datasource_disable_ssl		= false
  cl_ir_ml_hackathon_empathy_quicksight_s3_datasource_type			= "S3"

  cl_ir_ml_hackathon_empathy_quicksight_athena_datasource_name			= "cl-ir-hackathon-quicksight-athena-ds"
  cl_ir_ml_hackathon_empathy_quicksight_athena_datasource_description		= "CxLink Hackathon Empathy Assitant Quicksight Athena DataSource"
  cl_ir_ml_hackathon_empathy_quicksight_athena_datasource_username		= "cl-ir-hackathon-quicksight-ds"
  cl_ir_ml_hackathon_empathy_quicksight_athena_datasource_work_group		= "cl-ir-hackathon-quicksight-athena-ds"

  cl_ir_ml_hackathon_empathy_quicksight_athena_datasource_type			= "ATHENA"

  # Quicksight DataSets
}

