module "ml_mlops" {

  source  = "../../terraform/modules/ml/mlops"

  owner                                 = var.owner
  project                               = var.project
  region                                = var.region
  vpc_id                                = var.vpc_id
  private_subnet_ids			= var.private_subnet_ids
  default_profile                       = var.default_profile
  stage                                 = var.stage
  prefix                                = var.prefix

  # Global KMS Values

  cl_ir_ecr_kms_key_id                                          = var.cl_ir_ecr_kms_key_id
  cl_ir_cloudwatch_kms_key_id                                   = var.cl_ir_cloudwatch_kms_key_id
  cl_ir_lambda_kms_key_id                                       = var.cl_ir_lambda_kms_key_id
  cl_ir_s3_kms_key_id                                           = var.cl_ir_s3_kms_key_id
  cl_ir_glue_kms_key_id                                         = var.cl_ir_glue_kms_key_id

  cl_ir_s3_kms_key_alias					= var.cl_ir_s3_kms_key_alias
  cl_ir_ecr_kms_key_alias                                       = var.cl_ir_ecr_kms_key_alias
  cl_ir_cloudwatch_kms_key_alias                                = var.cl_ir_cloudwatch_kms_key_alias
  cl_ir_lambda_kms_key_alias                                    = var.cl_ir_lambda_kms_key_alias
  cl_ir_glue_kms_key_alias					= var.cl_ir_glue_kms_key_alias

  cl_ir_ml_hackathon_mlops_api_secret_value = "884tjlodnvbljkndlbkne"

  # CxLink Hackathon Emergencies Forecast MLOps S3 Buckets
  cl_ir_ml_hackathon_aws_forecast_raw_bucket_name                                  = "cl-ir-ml-aws-forecasting-raw-bucket"
  cl_ir_ml_hackathon_aws_forecast_curated_bucket_name                              = "cl-ir-ml-aws-forecasting-curated-bucket"

  # CxLink Hackathon Emergencies Forecast MLOps Pipeline

  cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_name = "cl-ir-ml-hackathon-mlops-artifacts"
  cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_lifecycle_archive_rule_name 		= "cl-ir-ml-hackathon-mlops-artifacts-rule"
  cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_lifecycle_glacier_rule_filter_key 		= ""
  cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_lifecycle_glacier_rule_filter_value 	= ""
  cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_lifecycle_archive_rule_glacier_days 	= 90
  cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_lifecycle_archive_rule_deep_days 		= 180

  cl_ir_ml_hackathon_mlops_pipeline_role_name			= "cl-ir-ml-hackathon-mlops-codepipeline-ir"
  cl_ir_ml_hackathon_mlops_pipeline_role_policy_name		= "cl-ir-ml-hackathon-mlops-codepipeline-irp"
  cl_ir_ml_hackathon_mlops_pipeline_codebuild_role_name		= "cl-ir-ml-hackathon-mlops-codebuild-ir"
  cl_ir_ml_hackathon_mlops_pipeline_codebuild_role_policy_name	= "cl-ir-ml-hackathon-mlops-codebuild-irp"
  cl_ir_ml_hackathon_mlops_pipeline_github_connection_name	= "cl-ir-ml-hackathon-mlops"
  cl_ir_ml_hackathon_mlops_pipeline_github_repo_name		= "cl-ir-ml-hackathon-mlops"
  cl_ir_ml_hackathon_mlops_pipeline_repo_name			= "cl-ir-ml-hackathon-mlops"
  cl_ir_ml_hackathon_mlops_pipeline_name			= "cl-ir-ml-hackathon-mlops"
  cl_ir_ml_hackathon_mlops_pipeline_repo_id			= ""
  cl_ir_ml_hackathon_mlops_pipeline_branch			= "master"
  cl_ir_ml_hackathon_mlops_project_name				= "cl-ir-ml-hackathon-mlops"

  cl_ir_ml_hackathon_mlops_pipeline_repo_approval_rule_name	= "cl-ir-ml-hackathon-mlops"
  cl_ir_ml_hackathon_mlops_pipeline_repo_approvers_arn		= "arn:aws:iam::585543526779:user/terraform-ht-dev"

  cl_ir_ml_hackathon_mlops_forecast_predictor_creation_wait_time = 30
  cl_ir_ml_hackathon_mlops_forecast_monitor_creation_wait_time   = 30
  cl_ir_ml_hackathon_mlops_forecast_forecast_creation_wait_time  = 30
  cl_ir_ml_hackathon_mlops_model_deploy_wait_time		 = 30

  # CxLink Hackathon Emergencies Forecast MLOps Global CodeBuild Projects

  cl_ir_ml_hackathon_mlops_log_group_retention			= 14
  cl_ir_ml_hackathon_mlops_codebuild_compute_type		= "BUILD_GENERAL1_SMALL"
  cl_ir_ml_hackathon_mlops_codebuild_image			= "aws/codebuild/amazonlinux2-aarch64-standard:2.0"
  cl_ir_ml_hackathon_mlops_codebuild_type			= "ARM_CONTAINER"
  cl_ir_ml_hackathon_mlops_codebuild_concurrent_build_limit	= 1
  cl_ir_ml_hackathon_mlops_codebuild_queued_timeout		= 10
  cl_ir_ml_hackathon_mlops_codebuild_privileged_mode_enabled	= true
  cl_ir_ml_hackathon_mlops_codebuild_security_group_name        = "cl-ir-ml-hackathon-mlops-codebuild"

  cl_ir_ml_hackathon_mlops_horizont			= 1
  cl_ir_ml_hackathon_mlops_dataset_format		= "CSV"
  cl_ir_ml_hackathon_mlops_target_dataset_filename	= "cl_ir_hackathon_erus_target"
  cl_ir_ml_hackathon_mlops_related_dataset_filename	= "cl_ir_hackathon_erus_related"
  cl_ir_ml_hackathon_mlops_timestamp_format		= "yyyy-MM-dd HH:mm:ss"
  cl_ir_ml_hackathon_mlops_dataset_group_name		= "cl_ir_hackathon_erus_cruz_roja"

  # CxLink Hackathon Emergencies Forecast MLOps CodeBuild Data PreProcessing Project

  cl_ir_ml_hackathon_mlops_data_preprocessing_name		= "cl-ir-hackathon-aws-forecast-data-preprocessing"
  cl_ir_ml_hackathon_mlops_data_preprocessing_description	= "CxLink Hackathon Emergencies Forecast MLOps Data PreProcessing"
  cl_ir_ml_hackathon_mlops_data_preprocessing_build_timeout	= 60
  cl_ir_ml_hackathon_mlops_data_preprocessing_branch		= "master"
  cl_ir_ml_hackathon_mlops_data_preprocessing_buildspec         = "mlops/codebuild/data-preprocessing/buildspec.yml"

  # CxLink Hackathon Emergencies Forecast MLOps CodeBuild Model Import Project

  cl_ir_ml_hackathon_mlops_import_test_mode		= "False"
  cl_ir_ml_hackathon_mlops_import_name			= "cl-ir-hackathon-aws-forecast-import"
  cl_ir_ml_hackathon_mlops_import_description		= "CxLink Hackathon Emergencies Forecast MLOps Import"
  cl_ir_ml_hackathon_mlops_import_build_timeout		= 60
  cl_ir_ml_hackathon_mlops_import_branch		= "master"
  cl_ir_ml_hackathon_mlops_import_buildspec           	= "mlops/codebuild/import/buildspec.yml"
  cl_ir_ml_hackathon_mlops_import_wait_time		= "30"
  cl_ir_ml_hackathon_mlops_import_mode			= "FULL"

  # CxLink Hackathon Emergencies Forecast MLOps CodeBuild Model Training Project

  cl_ir_ml_hackathon_mlops_training_test_mode		= "False"
  cl_ir_ml_hackathon_mlops_training_name		= "cl-ir-hackathon-aws-forecast-training"
  cl_ir_ml_hackathon_mlops_training_description		= "CxLink Hackathon Emergencies Forecast MLOps Training"
  cl_ir_ml_hackathon_mlops_training_build_timeout	= 240
  cl_ir_ml_hackathon_mlops_training_branch		= "master"
  cl_ir_ml_hackathon_mlops_training_buildspec           = "mlops/codebuild/training/buildspec.yml"
  cl_ir_ml_hackathon_mlops_forecast_frecuency		= "M"

  # CxLink Hackathon Emergencies Forecast MLOps CodeBuild Model Evaluation Project

  cl_ir_ml_hackathon_mlops_evaluation_name		= "cl-ir-hackathon-aws-forecast-evaluation"
  cl_ir_ml_hackathon_mlops_evaluation_description	= "CxLink Hackathon Emergencies Forecast MLOps evaluation"
  cl_ir_ml_hackathon_mlops_evaluation_build_timeout	= 60
  cl_ir_ml_hackathon_mlops_evaluation_branch		= "master"
  cl_ir_ml_hackathon_mlops_evaluation_buildspec         = "mlops/codebuild/evaluation/buildspec.yml"


  # CxLink Hackathon Emergencies Forecast MLOps CodeBuild Model Deploy Project

  cl_ir_ml_hackathon_mlops_model_deploy_name		 	= "cl-ir-hackathon-aws-forecast-model-deploy"
  cl_ir_ml_hackathon_mlops_model_deploy_description		= "CxLink Hackathon Emergencies Forecast MLOps Model Deploy"
  cl_ir_ml_hackathon_mlops_model_deploy_build_timeout		= 60
  cl_ir_ml_hackathon_mlops_model_deploy_branch		        = "master"
  cl_ir_ml_hackathon_mlops_model_deploy_buildspec               = "mlops/codebuild/model-deploy/buildspec.yml"
}


