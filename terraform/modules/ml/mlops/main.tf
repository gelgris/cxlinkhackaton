locals {
  environment = {
    dev   = "dev"
    pre   = "pre"
    prod  = "prod"
    test  = "test"
  }

  tags = {
    environment         = local.environment[terraform.workspace]
    project             = var.project
    owner               = var.owner
    stage               = var.stage
  }
}

data "aws_caller_identity" "current" {}

data "aws_kms_alias" "cl_ir_s3_kms_key_alias" {
  name = format("${var.cl_ir_s3_kms_key_alias}-%s",local.environment[terraform.workspace])
}

# CSV Repositories

resource "aws_codecommit_repository" "cl_ir_ml_hackathon_mlops_pipeline_repo" {
  repository_name = format("${var.cl_ir_ml_hackathon_mlops_pipeline_repo_name}-%s",local.environment[terraform.workspace])
  #default_branch  = var.cl_ir_ml_hackathon_mlops_pipeline_branch
  description     = "Code Repository for hosting the Hackathon for Good Code"

  lifecycle {
    ignore_changes = [
      default_branch
    ]
  }

  tags            = local.tags
}

resource "aws_codecommit_approval_rule_template" "cl_ir_ml_hackathon_mlops_pipeline_repo_approval" {
  name        = format("${var.cl_ir_ml_hackathon_mlops_pipeline_repo_approval_rule_name}-%s",local.environment[terraform.workspace])
  description = "Approval rule template for enabling approval process"

  content = <<EOF
{
    "Version": "2018-11-08",
    "DestinationReferences": ["refs/heads/${var.cl_ir_ml_hackathon_mlops_pipeline_branch}"],
    "Statements": [{
        "Type": "Approvers",
        "NumberOfApprovalsNeeded": 2,
        "ApprovalPoolMembers": ["${var.cl_ir_ml_hackathon_mlops_pipeline_repo_approvers_arn}"]
    }]
}
EOF
}

resource "aws_codecommit_approval_rule_template_association" "cl_ir_ml_hackathon_mlops_pipeline_repo_approval_association" {
  approval_rule_template_name = aws_codecommit_approval_rule_template.cl_ir_ml_hackathon_mlops_pipeline_repo_approval.name
  repository_name             = aws_codecommit_repository.cl_ir_ml_hackathon_mlops_pipeline_repo.repository_name
}

resource "aws_codepipeline" "cl_ir_ml_hackathon_mlops_pipeline" {
  name     = format("${var.cl_ir_ml_hackathon_mlops_pipeline_name}-%s",local.environment[terraform.workspace])
  role_arn = aws_iam_role.cl_ir_ml_hackathon_mlops_pipeline_role.arn
  tags = local.tags

  artifact_store {
    location = aws_s3_bucket.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket.bucket
    type     = "S3"

    encryption_key {
      id   = data.aws_kms_alias.cl_ir_s3_kms_key_alias.arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name             = "DownloadSources"
      category         = "Source"
      owner            = "AWS"
      version          = "1"
      provider         = "CodeCommit"
      namespace        = "SourceVariables"
      output_artifacts = ["source_output"]
      run_order        = 1

      configuration = {
        RepositoryName       = format("${var.cl_ir_ml_hackathon_mlops_pipeline_repo_name}-%s",local.environment[terraform.workspace])
        BranchName           = var.cl_ir_ml_hackathon_mlops_pipeline_branch
        PollForSourceChanges = "true"
      }
    }

    #action {
    #  name             = "DownloadExternalSources"
    #  category         = "Source"
    #  owner            = "AWS"
    #  provider         = "CodeStarSourceConnection"
    #  version          = "1"
    #  output_artifacts = ["external_source_output"]

    #  configuration = {
    #    ConnectionArn    = aws_codestarconnections_connection.cl_ir_ml_hackathon_mlops_pipeline_github_connection.arn
    #    FullRepositoryId = var.cl_ir_ml_hackathon_mlops_pipeline_repo_id
    #    BranchName       = var.cl_ir_ml_hackathon_mlops_pipeline_branch
    #  }
    #}
  }

  #stage {
  #  name = "DataPreprocessing"
  #
  #  action {
  #    name             = "Preprocessing"
  #    category         = "Build"
  #    owner            = "AWS"
  #    provider         = "CodeBuild"
  #    input_artifacts  = ["source_output"]
  #    output_artifacts = ["preprocessing_output"]
  #    version          = "1"
  #    run_order        = 2
  #
  #    configuration = {
  #      ProjectName = aws_codebuild_project.cl_ir_ml_hackathon_mlops_data_preprocessing.id
  #    }
  #  }
  #}

  stage {
    name = "ModelTraining"

    action {
      name             = "Import"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      #input_artifacts  = ["preprocessing_output"]
      input_artifacts  = ["source_output"]
      output_artifacts = ["import_output"]
      version          = "1"
      run_order        = 2

      configuration = {
        ProjectName = aws_codebuild_project.cl_ir_ml_hackathon_mlops_import.id
      }
    }

    action {
      name             = "Training"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["training_output"]
      version          = "1"
      run_order        = 4

      configuration = {
        ProjectName = aws_codebuild_project.cl_ir_ml_hackathon_mlops_training.id
      }
    }
  }

  #stage {
  #  name = "ModelEvaluation"
   #
    #action {
    #  name             = "Evaluation"
    #  category         = "Build"
    #  owner            = "AWS"
    #  provider         = "CodeBuild"
    #  input_artifacts  = ["training_output"]
    #  output_artifacts = ["evaluation_output"]
    #  version          = "1"
    #  run_order        = 5
    #
    #  configuration = {
    #    ProjectName = aws_codebuild_project.cl_ir_ml_hackathon_mlops_evaluation.id
    #  }
    #}
  #}

  stage {
    name = "ModelDeploy"

    action {
      name             = "Deploy"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["model_deploy_output"]
      version          = "1"
      run_order        = 5

      configuration = {
        ProjectName = aws_codebuild_project.cl_ir_ml_hackathon_mlops_model_deploy.id
      }
    }
  }
}

# CxLink Hackathon Emergencies Forecast MLOps CodeBuild Data PreProcessing Project

resource "aws_cloudwatch_log_group" "cl_ir_ml_hackathon_mlops_data_preprocessing_log_group" {
  name              = format("${var.cl_ir_ml_hackathon_mlops_data_preprocessing_name}-%s",local.environment[terraform.workspace])
  retention_in_days = var.cl_ir_ml_hackathon_mlops_log_group_retention
}


#resource "aws_codebuild_project" "cl_ir_ml_hackathon_mlops_data_preprocessing" {
#  name           = format("${var.cl_ir_ml_hackathon_mlops_data_preprocessing_name}-%s",local.environment[terraform.workspace])
#  description    = var.cl_ir_ml_hackathon_mlops_data_preprocessing_description
#  service_role   = aws_iam_role.cl_ir_ml_hackathon_mlops_pipeline_codebuild_role.arn
#  resource_access_role = aws_iam_role.cl_ir_ml_hackathon_mlops_pipeline_codebuild_role.arn
#  build_timeout  = var.cl_ir_ml_hackathon_mlops_data_preprocessing_build_timeout
#  concurrent_build_limit = var.cl_ir_ml_hackathon_mlops_codebuild_concurrent_build_limit
#  encryption_key = "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_ecr_kms_key_id}"
#  queued_timeout = var.cl_ir_ml_hackathon_mlops_codebuild_queued_timeout
#  project_visibility = "PRIVATE"
#  source_version = var.cl_ir_ml_hackathon_mlops_data_preprocessing_branch
#
#  artifacts {
#    type = "CODEPIPELINE"
#    encryption_disabled = false
#    override_artifact_name = true
#  }
#
#  cache {
#    type     = "S3"
#    location = aws_s3_bucket.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket.bucket
#  }
#
#  environment {
#    compute_type                = var.cl_ir_ml_hackathon_mlops_codebuild_compute_type
#    image                       = var.cl_ir_ml_hackathon_mlops_codebuild_image
#    type                         var.cl_ir_ml_hackathon_mlops_codebuild_type
#    image_pull_credentials_type = "CODEBUILD"
#    privileged_mode             = var.cl_ir_ml_hackathon_mlops_codebuild_privileged_mode_enabled
#
#    environment_variable {
#      name = "REGION"
#      value= var.region
#    }
#
#    environment_variable {
#      name = "ENVIRONMENT_TAG"
#      value= local.environment[terraform.workspace]
#    }
#
#    environment_variable {
#      name = "PROJECT_TAG"
#      value= var.project
#    }
#
#    environment_variable {
#      name = "OWNER_TAG"
#      value= var.owner
#    }
#
#    environment_variable {
#      name = "STAGE_TAG"
#      value= var.stage
#    }
#
#    environment_variable {
#      name = "PREFIX"
#      value= var.prefix
#    }
#
#    environment_variable {
#      name = "USE_CASE"
#      value= var.cl_ir_ml_cl_sample_use_case
#    }
#
#    environment_variable {
#      name = "HORIZONT"
#      value= var.cl_ir_ml_hackathon_mlops_horizont
#    }
#
#    environment_variable {
#      name = "TEST_MODE"
#      value= var.cl_ir_ml_hackathon_mlops_import_test_mode
#    }
#
#    environment_variable {
#
#      name = "DATASET_FORMAT"
#      value= var.cl_ir_ml_hackathon_mlops_dataset_format
#    }
#
#    environment_variable {
#
#      name = "TARGET_DATASET_FILENAME"
#      value= var.cl_ir_ml_hackathon_mlops_target_dataset_filename
#    }
#
#    environment_variable {
#
#      name = "RELATED_DATASET_FILENAME"
#      value= var.cl_ir_ml_hackathon_mlops_related_dataset_filename
#    }
#
#    environment_variable {
#
#      name = "TIMESTAMP_FORMAT"
#      value= var.cl_ir_ml_hackathon_mlops_timestamp_format
#    }
#
#    environment_variable {
#
#      name = "CUSTOMER_ID"
#      value= var.customer_id
#    }
#
#    environment_variable {
#
#      name = "DATASET_GROUP_NAME"
#      value= var.cl_ir_ml_hackathon_mlops_dataset_group_name
#    }
#
#    environment_variable {
#
#      name = "IMPORT_WAIT_TIME"
#      value= var.cl_ir_ml_hackathon_mlops_import_wait_time
#    }
#
#    environment_variable {
#
#      name = "IMPORT_MODE"
#      value= var.cl_ir_ml_hackathon_mlops_import_mode
#    }
#  }
#  logs_config {
#    cloudwatch_logs {
#      group_name  = aws_cloudwatch_log_group.cl_ir_ml_hackathon_mlops_data_preprocessing_log_group.name
#      stream_name = "log-stream"
#    }
#
#    s3_logs {
#      status   = "ENABLED"
#      location = "${aws_s3_bucket.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket.id}/build-log"
#    }
#  }
#
#  source {
#    type      = "CODEPIPELINE"
#    buildspec = var.cl_ir_ml_hackathon_mlops_data_preprocessing_buildspec
#  }

  # Error: updating CodeBuild project (arn:aws:codebuild:eu-west-1:585543526779:project/cl-ir-hackathon-aws-forecast-data-preprocessing-dev): InvalidInputException: Not authorized to perform DescribeSecurityGroups
  # TODO: Enable VPC It we need it

  #vpc_config {
  #  vpc_id = var.vpc_id
  #
  #  subnets = var.private_subnet_ids
  #
  #  security_group_ids = [
  #    aws_security_group.cl_ir_ml_hackathon_mlops_codebuild_security_group.id
  #  ]
  #}

#  tags = local.tags
#}

# CxLink Hackathon Emergencies Forecast MLOps CodeBuild Data Import Project

resource "aws_cloudwatch_log_group" "cl_ir_ml_hackathon_mlops_import_log_group" {
  name              = format("${var.cl_ir_ml_hackathon_mlops_import_name}-%s",local.environment[terraform.workspace])
  retention_in_days = var.cl_ir_ml_hackathon_mlops_log_group_retention
}

resource "aws_codebuild_project" "cl_ir_ml_hackathon_mlops_import" {
  name           = format("${var.cl_ir_ml_hackathon_mlops_import_name}-%s",local.environment[terraform.workspace])
  description    = var.cl_ir_ml_hackathon_mlops_import_description
  service_role   = aws_iam_role.cl_ir_ml_hackathon_mlops_pipeline_codebuild_role.arn
  resource_access_role = aws_iam_role.cl_ir_ml_hackathon_mlops_pipeline_codebuild_role.arn
  build_timeout  = var.cl_ir_ml_hackathon_mlops_import_build_timeout
  concurrent_build_limit = var.cl_ir_ml_hackathon_mlops_codebuild_concurrent_build_limit
  encryption_key = "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_ecr_kms_key_id}"
  queued_timeout = var.cl_ir_ml_hackathon_mlops_codebuild_queued_timeout
  project_visibility = "PRIVATE"
  source_version = var.cl_ir_ml_hackathon_mlops_import_branch

  artifacts {
    type = "CODEPIPELINE"
    encryption_disabled = false
    override_artifact_name = true
  }

  cache {
    type     = "S3"
    location = aws_s3_bucket.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket.bucket
  }

  environment {
    compute_type                = var.cl_ir_ml_hackathon_mlops_codebuild_compute_type
    image                       = var.cl_ir_ml_hackathon_mlops_codebuild_image
    type                        = var.cl_ir_ml_hackathon_mlops_codebuild_type
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = var.cl_ir_ml_hackathon_mlops_codebuild_privileged_mode_enabled

    environment_variable {
      name = "REGION"
      value= var.region
    }

    environment_variable {
      name = "ENVIRONMENT_TAG"
      value= local.environment[terraform.workspace]
    }

    environment_variable {
      name = "PROJECT_TAG"
      value= var.project
    }

    environment_variable {
      name = "OWNER_TAG"
      value= var.owner
    }

    environment_variable {
      name = "STAGE_TAG"
      value= var.stage
    }

    environment_variable {
      name = "PREFIX"
      value= var.prefix
    }

    environment_variable {
      name = "USE_CASE"
      value= var.cl_ir_ml_cl_sample_use_case
    }

    environment_variable {
      name = "HORIZONT"
      value= var.cl_ir_ml_hackathon_mlops_horizont
    }

    environment_variable {
      name = "TEST_MODE"
      value= var.cl_ir_ml_hackathon_mlops_import_test_mode
    }

    environment_variable {
      name = "DATASET_FORMAT"
      value= var.cl_ir_ml_hackathon_mlops_dataset_format
    }

    environment_variable {
      name = "TARGET_DATASET_FILENAME"
      value= var.cl_ir_ml_hackathon_mlops_target_dataset_filename
    }

    environment_variable {
      name = "RELATED_DATASET_FILENAME"
      value= var.cl_ir_ml_hackathon_mlops_related_dataset_filename
    }

    environment_variable {
      name = "TIMESTAMP_FORMAT"
      value= var.cl_ir_ml_hackathon_mlops_timestamp_format
    }

    environment_variable {
      name = "CUSTOMER_ID"
      value= var.customer_id
    }

    environment_variable {
      name = "DATASET_GROUP_NAME"
      value= var.cl_ir_ml_hackathon_mlops_dataset_group_name
    }

    environment_variable {
      name = "IMPORT_WAIT_TIME"
      value= var.cl_ir_ml_hackathon_mlops_import_wait_time
    }

    environment_variable {
      name = "IMPORT_MODE"
      value= var.cl_ir_ml_hackathon_mlops_import_mode
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = aws_cloudwatch_log_group.cl_ir_ml_hackathon_mlops_import_log_group.name
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket.id}/build-log"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = var.cl_ir_ml_hackathon_mlops_import_buildspec
  }

  # Error: updating CodeBuild project (arn:aws:codebuild:eu-west-1:585543526779:project/cl-ir-hackathon-aws-forecast-data-preprocessing-dev): InvalidInputException: Not authorized to perform DescribeSecurityGroups
  # TODO: Enable VPC It we need it

  #vpc_config {
  #  vpc_id = var.vpc_id
  #
  #  subnets = var.private_subnet_ids
  #
  #  security_group_ids = [
  #    aws_security_group.cl_ir_ml_hackathon_mlops_codebuild_security_group.id
  #  ]
  #}

  tags = local.tags
}


# CxLink Hackathon Emergencies Forecast MLOps CodeBuild Training Project

resource "aws_cloudwatch_log_group" "cl_ir_ml_hackathon_mlops_training_log_group" {
  name              = format("${var.cl_ir_ml_hackathon_mlops_training_name}-%s",local.environment[terraform.workspace])
  retention_in_days = var.cl_ir_ml_hackathon_mlops_log_group_retention
}

resource "aws_codebuild_project" "cl_ir_ml_hackathon_mlops_training" {
  name           = format("${var.cl_ir_ml_hackathon_mlops_training_name}-%s",local.environment[terraform.workspace])
  description    = var.cl_ir_ml_hackathon_mlops_training_description
  service_role   = aws_iam_role.cl_ir_ml_hackathon_mlops_pipeline_codebuild_role.arn
  resource_access_role = aws_iam_role.cl_ir_ml_hackathon_mlops_pipeline_codebuild_role.arn
  build_timeout  = var.cl_ir_ml_hackathon_mlops_training_build_timeout
  concurrent_build_limit = var.cl_ir_ml_hackathon_mlops_codebuild_concurrent_build_limit
  encryption_key = "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_ecr_kms_key_id}"
  queued_timeout = var.cl_ir_ml_hackathon_mlops_codebuild_queued_timeout
  project_visibility = "PRIVATE"
  source_version = var.cl_ir_ml_hackathon_mlops_training_branch

  artifacts {
    type = "CODEPIPELINE"
    encryption_disabled = false
    override_artifact_name = true
  }

  cache {
    type     = "S3"
    location = aws_s3_bucket.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket.bucket
  }

  environment {
    compute_type                = var.cl_ir_ml_hackathon_mlops_codebuild_compute_type
    image                       = var.cl_ir_ml_hackathon_mlops_codebuild_image
    type                        = var.cl_ir_ml_hackathon_mlops_codebuild_type
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = var.cl_ir_ml_hackathon_mlops_codebuild_privileged_mode_enabled

    environment_variable {
      name = "REGION"
      value= var.region
    }

    environment_variable {
      name = "ENVIRONMENT_TAG"
      value= local.environment[terraform.workspace]
    }

    environment_variable {
      name = "PROJECT_TAG"
      value= var.project
    }

    environment_variable {
      name = "OWNER_TAG"
      value= var.owner
    }

    environment_variable {
      name = "STAGE_TAG"
      value= var.stage
    }

    environment_variable {
      name = "PREFIX"
      value= var.prefix
    }

    environment_variable {
      name = "USE_CASE"
      value= var.cl_ir_ml_cl_sample_use_case
    }

    environment_variable {
      name = "HORIZONT"
      value= var.cl_ir_ml_hackathon_mlops_horizont
    }

    environment_variable {
      name = "TEST_MODE"
      value= var.cl_ir_ml_hackathon_mlops_training_test_mode
    }

    environment_variable {

      name = "DATASET_FORMAT"
      value= var.cl_ir_ml_hackathon_mlops_dataset_format
    }

    environment_variable {

      name = "TARGET_DATASET_FILENAME"
      value= var.cl_ir_ml_hackathon_mlops_target_dataset_filename
    }

    environment_variable {

      name = "RELATED_DATASET_FILENAME"
      value= var.cl_ir_ml_hackathon_mlops_related_dataset_filename
    }

    environment_variable {

      name = "TIMESTAMP_FORMAT"
      value= var.cl_ir_ml_hackathon_mlops_timestamp_format
    }

    environment_variable {

      name = "CUSTOMER_ID"
      value= var.customer_id
    }

    environment_variable {

      name = "DATASET_GROUP_NAME"
      value= var.cl_ir_ml_hackathon_mlops_dataset_group_name
    }

    environment_variable {

      name = "IMPORT_WAIT_TIME"
      value= var.cl_ir_ml_hackathon_mlops_import_wait_time
    }

    environment_variable {

      name = "FORECAST_FRECUENCY"
      value= var.cl_ir_ml_hackathon_mlops_forecast_frecuency
    }

    environment_variable {

      name = "PREDICTOR_CREATION_WAIT_TIME"
      value= var.cl_ir_ml_hackathon_mlops_forecast_predictor_creation_wait_time
    }

    environment_variable {

      name = "MONITOR_CREATION_WAIT_TIME"
      value= var.cl_ir_ml_hackathon_mlops_forecast_monitor_creation_wait_time
    }

    environment_variable {

      name = "FORECAST_CREATION_WAIT_TIME"
      value= var.cl_ir_ml_hackathon_mlops_forecast_forecast_creation_wait_time
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = aws_cloudwatch_log_group.cl_ir_ml_hackathon_mlops_training_log_group.name
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket.id}/build-log"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = var.cl_ir_ml_hackathon_mlops_training_buildspec
  }

  # Error: updating CodeBuild project (arn:aws:codebuild:eu-west-1:585543526779:project/cl-ir-hackathon-aws-forecast-data-preprocessing-dev): InvalidInputException: Not authorized to perform DescribeSecurityGroups
  # TODO: Enable VPC It we need it

  #vpc_config {
  #  vpc_id = var.vpc_id
  #
  #  subnets = var.private_subnet_ids
  #
  #  security_group_ids = [
  #    aws_security_group.cl_ir_ml_hackathon_mlops_codebuild_security_group.id
  #  ]
  #}

  tags = local.tags
}

# CxLink Hackathon Emergencies Forecast MLOps CodeBuild Evaluation Project

resource "aws_cloudwatch_log_group" "cl_ir_ml_hackathon_mlops_evaluation_log_group" {
  name              = format("${var.cl_ir_ml_hackathon_mlops_evaluation_name}-%s",local.environment[terraform.workspace])
  retention_in_days = var.cl_ir_ml_hackathon_mlops_log_group_retention
}

resource "aws_codebuild_project" "cl_ir_ml_hackathon_mlops_evaluation" {
  name           = format("${var.cl_ir_ml_hackathon_mlops_evaluation_name}-%s",local.environment[terraform.workspace])
  description    = var.cl_ir_ml_hackathon_mlops_evaluation_description
  service_role   = aws_iam_role.cl_ir_ml_hackathon_mlops_pipeline_codebuild_role.arn
  resource_access_role = aws_iam_role.cl_ir_ml_hackathon_mlops_pipeline_codebuild_role.arn
  build_timeout  = var.cl_ir_ml_hackathon_mlops_evaluation_build_timeout
  concurrent_build_limit = var.cl_ir_ml_hackathon_mlops_codebuild_concurrent_build_limit
  encryption_key = "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_ecr_kms_key_id}"
  queued_timeout = var.cl_ir_ml_hackathon_mlops_codebuild_queued_timeout
  project_visibility = "PRIVATE"
  source_version = var.cl_ir_ml_hackathon_mlops_evaluation_branch

  artifacts {
    type = "CODEPIPELINE"
    encryption_disabled = false
    override_artifact_name = true
  }

  cache {
    type     = "S3"
    location = aws_s3_bucket.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket.bucket
  }

  environment {
    compute_type                = var.cl_ir_ml_hackathon_mlops_codebuild_compute_type
    image                       = var.cl_ir_ml_hackathon_mlops_codebuild_image
    type                        = var.cl_ir_ml_hackathon_mlops_codebuild_type
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = var.cl_ir_ml_hackathon_mlops_codebuild_privileged_mode_enabled

    environment_variable {
      name = "REGION"
      value= var.region
    }

    environment_variable {
      name = "ENVIRONMENT_TAG"
      value= local.environment[terraform.workspace]
    }

    environment_variable {
      name = "PROJECT_TAG"
      value= var.project
    }

    environment_variable {
      name = "OWNER_TAG"
      value= var.owner
    }

    environment_variable {
      name = "STAGE_TAG"
      value= var.stage
    }

    environment_variable {
      name = "PREFIX"
      value= var.prefix
    }

    environment_variable {
      name = "USE_CASE"
      value= var.cl_ir_ml_cl_sample_use_case
    }

    environment_variable {
      name = "HORIZONT"
      value= var.cl_ir_ml_hackathon_mlops_horizont
    }

    environment_variable {
      name = "TEST_MODE"
      value= var.cl_ir_ml_hackathon_mlops_import_test_mode
    }

    environment_variable {

      name = "DATASET_FORMAT"
      value= var.cl_ir_ml_hackathon_mlops_dataset_format
    }

    environment_variable {

      name = "TARGET_DATASET_FILENAME"
      value= var.cl_ir_ml_hackathon_mlops_target_dataset_filename
    }

    environment_variable {

      name = "RELATED_DATASET_FILENAME"
      value= var.cl_ir_ml_hackathon_mlops_related_dataset_filename
    }

    environment_variable {

      name = "TIMESTAMP_FORMAT"
      value= var.cl_ir_ml_hackathon_mlops_timestamp_format
    }

    environment_variable {

      name = "CUSTOMER_ID"
      value= var.customer_id
    }

    environment_variable {

      name = "DATASET_GROUP_NAME"
      value= var.cl_ir_ml_hackathon_mlops_dataset_group_name
    }

    environment_variable {

      name = "IMPORT_WAIT_TIME"
      value= var.cl_ir_ml_hackathon_mlops_import_wait_time
    }

    environment_variable {

      name = "IMPORT_MODE"
      value= var.cl_ir_ml_hackathon_mlops_import_mode
    }

  }

  logs_config {
    cloudwatch_logs {
      group_name  = aws_cloudwatch_log_group.cl_ir_ml_hackathon_mlops_evaluation_log_group.name
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket.id}/build-log"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = var.cl_ir_ml_hackathon_mlops_evaluation_buildspec
  }

  # Error: updating CodeBuild project (arn:aws:codebuild:eu-west-1:585543526779:project/cl-ir-hackathon-aws-forecast-data-preprocessing-dev): InvalidInputException: Not authorized to perform DescribeSecurityGroups
  # TODO: Enable VPC It we need it

  #vpc_config {
  #  vpc_id = var.vpc_id
  #
  #  subnets = var.private_subnet_ids
  #
  #  security_group_ids = [
  #    aws_security_group.cl_ir_ml_hackathon_mlops_codebuild_security_group.id
  #  ]
  #}

  tags = local.tags
}

# CxLink Hackathon Emergencies Forecast MLOps CodeBuild Model Deploy Project

resource "aws_cloudwatch_log_group" "cl_ir_ml_hackathon_mlops_model_deploy_log_group" {
  name              = format("${var.cl_ir_ml_hackathon_mlops_model_deploy_name}-%s",local.environment[terraform.workspace])
  retention_in_days = var.cl_ir_ml_hackathon_mlops_log_group_retention
}

resource "aws_codebuild_project" "cl_ir_ml_hackathon_mlops_model_deploy" {
  name           = format("${var.cl_ir_ml_hackathon_mlops_model_deploy_name}-%s",local.environment[terraform.workspace])
  description    = var.cl_ir_ml_hackathon_mlops_model_deploy_description
  service_role   = aws_iam_role.cl_ir_ml_hackathon_mlops_pipeline_codebuild_role.arn
  resource_access_role = aws_iam_role.cl_ir_ml_hackathon_mlops_pipeline_codebuild_role.arn
  build_timeout  = var.cl_ir_ml_hackathon_mlops_model_deploy_build_timeout
  concurrent_build_limit = var.cl_ir_ml_hackathon_mlops_codebuild_concurrent_build_limit
  encryption_key = "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_ecr_kms_key_id}"
  queued_timeout = var.cl_ir_ml_hackathon_mlops_codebuild_queued_timeout
  project_visibility = "PRIVATE"
  source_version = var.cl_ir_ml_hackathon_mlops_model_deploy_branch

  artifacts {
    type = "CODEPIPELINE"
    encryption_disabled = false
    override_artifact_name = true
  }

  cache {
    type     = "S3"
    location = aws_s3_bucket.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket.bucket
  }

  environment {
    compute_type                = var.cl_ir_ml_hackathon_mlops_codebuild_compute_type
    image                       = var.cl_ir_ml_hackathon_mlops_codebuild_image
    type                        = var.cl_ir_ml_hackathon_mlops_codebuild_type
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = var.cl_ir_ml_hackathon_mlops_codebuild_privileged_mode_enabled

    environment_variable {
      name = "REGION"
      value= var.region
    }

    environment_variable {
      name = "ENVIRONMENT_TAG"
      value= local.environment[terraform.workspace]
    }

    environment_variable {
      name = "PROJECT_TAG"
      value= var.project
    }

    environment_variable {
      name = "OWNER_TAG"
      value= var.owner
    }

    environment_variable {
      name = "STAGE_TAG"
      value= var.stage
    }

    environment_variable {
      name = "PREFIX"
      value= var.prefix
    }

    environment_variable {
      name = "USE_CASE"
      value= var.cl_ir_ml_cl_sample_use_case
    }

    environment_variable {
      name = "HORIZONT"
      value= var.cl_ir_ml_hackathon_mlops_horizont
    }

    environment_variable {
      name = "TEST_MODE"
      value= var.cl_ir_ml_hackathon_mlops_import_test_mode
    }

    environment_variable {

      name = "DATASET_FORMAT"
      value= var.cl_ir_ml_hackathon_mlops_dataset_format
    }

    environment_variable {

      name = "TARGET_DATASET_FILENAME"
      value= var.cl_ir_ml_hackathon_mlops_target_dataset_filename
    }

    environment_variable {

      name = "RELATED_DATASET_FILENAME"
      value= var.cl_ir_ml_hackathon_mlops_related_dataset_filename
    }

    environment_variable {

      name = "TIMESTAMP_FORMAT"
      value= var.cl_ir_ml_hackathon_mlops_timestamp_format
    }

    environment_variable {

      name = "CUSTOMER_ID"
      value= var.customer_id
    }

    environment_variable {

      name = "DATASET_GROUP_NAME"
      value= var.cl_ir_ml_hackathon_mlops_dataset_group_name
    }

    environment_variable {

      name = "MODEL_DEPLOY_WAIT_TIME"
      value= var.cl_ir_ml_hackathon_mlops_model_deploy_wait_time
    }

    environment_variable {

      name = "IMPORT_MODE"
      value= var.cl_ir_ml_hackathon_mlops_import_mode
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = aws_cloudwatch_log_group.cl_ir_ml_hackathon_mlops_model_deploy_log_group.name
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket.id}/build-log"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = var.cl_ir_ml_hackathon_mlops_model_deploy_buildspec
  }

  # Error: updating CodeBuild project (arn:aws:codebuild:eu-west-1:585543526779:project/cl-ir-hackathon-aws-forecast-data-preprocessing-dev): InvalidInputException: Not authorized to perform DescribeSecurityGroups
  # TODO: Enable VPC It we need it

  #vpc_config {
  #  vpc_id = var.vpc_id
  #
  #  subnets = var.private_subnet_ids
  #
  #  security_group_ids = [
  #    aws_security_group.cl_ir_ml_hackathon_mlops_codebuild_security_group.id
  #  ]
  #}

  tags = local.tags
}
