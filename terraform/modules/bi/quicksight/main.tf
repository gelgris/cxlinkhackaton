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

data "aws_caller_identity" "current" {
   provider = aws.account-742189430206-eu-west-1
}


#resource "aws_quicksight_account_subscription" "cl_ir_ml_hackathon_empathy_quicksight" {
#  provider = aws.account-742189430206-eu-west-1
#
#  account_name          = format("${var.cl_ir_ml_hackathon_empathy_quicksight_account_name}-%s",local.environment[terraform.workspace])
#  authentication_method = var.cl_ir_ml_hackathon_empathy_quicksight_authentication_method
#  edition               = var.cl_ir_ml_hackathon_empathy_quicksight_edition
#  notification_email    = var.cl_ir_ml_hackathon_empathy_quicksight_notification_email
#}

#resource "aws_quicksight_group" "cl_ir_ml_hackathon_empathy_quicksight_cruz_roja" {
#  provider = aws.account-742189430206-eu-west-1  
#
#  group_name = format("${var.cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_group_name}-%s",local.environment[terraform.workspace])
#  description = var.cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_group_description
#  namespace = "default"
#  aws_account_id = data.aws_caller_identity.current.account_id
#}


#resource "aws_quicksight_user" "cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_author_user" {
#  provider = aws.account-742189430206-eu-west-1

  #session_name  = var.cl_ir_ml_hackathon_empathy_quicksight_s3_ds_user_session_name
#  email         = var.cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_author_user_email
#  identity_type = "IAM"
#  iam_arn       = aws_iam_user.cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_author_user.arn
#  user_role     = var.cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_author_user_role
#  namespace     = "default"
#}


#resource "aws_quicksight_user" "cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_admin_user" {
#  provider = aws.account-742189430206-eu-west-1

  #session_name  = var.cl_ir_ml_hackathon_empathy_quicksight_s3_ds_user_session_name
#  email         = var.cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_admin_user_email
#  identity_type = "IAM"
#  iam_arn       = aws_iam_user.cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_admin_user.arn
#  user_role     = var.cl_ir_ml_hackathon_empathy_quicksight_cruz_roja_iam_admin_user_role
#  namespace     = "default"
#}


# TODO: No funciona
#resource "aws_quicksight_iam_policy_assignment" "cl_ir_ml_hackathon_empathy_quicksight_s3_ds_user_policy" {
#  assignment_name   = "cl-ir-ml-hackathon-empathy-assistant-quicksight-s3-ds-user"
#  assignment_status = "ENABLED"
#  policy_arn        = aws_iam_policy.cl_ir_ml_hackathon_empathy_quicksight_s3_ds_iam_user_policy.arn
#  identities {
#    user = [aws_quicksight_user.cl_ir_ml_hackathon_empathy_quicksight_s3_ds_user.user_name]
#  }
#}

#resource "aws_quicksight_group_membership" "cl_ir_ml_hackathon_empathy_quicksight_membership" {
#  group_name  = aws_quicksight_group.cl_ir_ml_hackathon_empathy_quicksight_cruz_roja.group_name
#  member_name = var.
#  aws_account_id = data.aws_caller_identity.current.account_id
#  namespace = "default"
#}

#resource "aws_quicksight_namespace" "cl_ir_ml_hackathon_empathy_quicksight_namespace" {
#  namespace = var.cl_ir_ml_hackathon_empathy_quicksight_namespace
#  aws_account_id = data.aws_caller_identity.current.account_id
#  identity_store = 'QUICKSIGHT'
#  tags = local.tags
#}

#resource "aws_quicksight_ingestion" "cl_ir_ml_hackathon_empathy_quicksight_ingestion" {
#  data_set_id    = aws_quicksight_data_set..data_set_id
#  ingestion_id   =
#  ingestion_type = "FULL_REFRESH"
#}


#resource "aws_quicksight_data_source" "cl_ir_ml_hackathon_empathy_quicksight_s3_datasource" {
#  data_source_id = format("${var.cl_ir_ml_hackathon_empathy_quicksight_s3_datasource_name}-%s",local.environment[terraform.workspace])
#  name           = var.cl_ir_ml_hackathon_empathy_quicksight_s3_datasource_description
#  aws_account_id = data.aws_caller_identity.current.account_id
#  credentials {
    #TODO: Securize
    #copy_source_arn : TODO
#    credential_pair  {
#      username = format("${var.cl_ir_ml_hackathon_empathy_quicksight_s3_datasource_username}-%s",local.environment[terraform.workspace])
#      password = data.aws_secretsmanager_random_password.cl_ir_ml_hackathon_empathy_quicksight_secret_password.random_password
#    }
#  }
#
#  permission {
#    actions = ["s3:*","kms:*"]
#    principal = aws_iam_user.cl_ir_ml_hackathon_empathy_quicksight_s3_ds_iam_user.arn
#  }
#
#  ssl_properties {
#    disable_ssl = var.cl_ir_ml_hackathon_empathy_quicksight_s3_datasource_disable_ssl
#  }

#  parameters {
#    s3 {
#      manifest_file_location {
#        bucket = format("${var.cl_ir_ml_hackathon_empathy_quicksight_bucket_name}-%s",local.environment[terraform.workspace])
#        key    = format("${data.aws_caller_identity.current.account_id}/${var.region}/quicksight/ds-manifests/${var.cl_ir_ml_hackathon_empathy_quicksight_s3_datasource_s3_manifest_key}-%s.json",local.environment[terraform.workspace])
#      }
#    }
#  }
#
#  type = var.cl_ir_ml_hackathon_empathy_quicksight_s3_datasource_type

  #TODO: Implement If we need.

  #vpc_connection_properties {
  #  vpc_connection_arn  = "arn:aws:quicksight:${var.region}:${data.aws_caller_identity.current.account_id}:vpcConnection/test-01"}
  #}

#  tags = local.tags
#}



#resource "aws_quicksight_data_source" "cl_ir_ml_hackathon_empathy_quicksight_athena_datasource" {
#  provider = aws.account-742189430206-eu-west-1

#  data_source_id = format("${var.cl_ir_ml_hackathon_empathy_quicksight_athena_datasource_name}-%s",local.environment[terraform.workspace])
#  name           = var.cl_ir_ml_hackathon_empathy_quicksight_athena_datasource_description
#  aws_account_id = data.aws_caller_identity.current.account_id

  #permission {
  #}

  #ssl_properties {
  #}

#  parameters {
#    athena {
#      #work_group = aws_athena_workgroup.cl_ir_ml_hackathon_empathy_quicksight_athena_wg.name
#      work_group = "primary"
#    }
#  }

#  type = var.cl_ir_ml_hackathon_empathy_quicksight_athena_datasource_type

  #vpc_connection_properties {
  #  vpc_connection_arn  = var.cl_ir_ml_hackathon_empathy_quicksight_vpc_arn
  #}

#  tags = local.tags
#}

