module "landing-zone_742189430206_eu-south-2_kms" {

  source  = "../../terraform/modules/landing_zone/742189430206/eu-south-2/kms"

  providers = {
            aws.account-742189430206-eu-south-2 = aws.account-742189430206-eu-south-2
  }

  owner					= var.owner
  project				= var.project
  region                                = var.region

  cl_ir_sqs_kms_key_alias_name		= "cl-ir-lz-sqs"
  cl_ir_sqs_kms_key_description		= "CxLink Ireland Landing Zone sqs Buckets Encryption Custom KMS Key"
  cl_ir_sqs_kms_key_retention		= 10

  cl_ir_efs_kms_key_alias_name		= "cl-ir-lz-efs"
  cl_ir_efs_kms_key_description		= "CxLink Ireland Landing Zone efs Buckets Encryption Custom KMS Key"
  cl_ir_efs_kms_key_retention		= 10

  cl_ir_sagemaker_kms_key_alias_name	= "cl-ir-lz-sagemaker"
  cl_ir_sagemaker_kms_key_description	= "CxLink Ireland Landing Zone sagemaker Buckets Encryption Custom KMS Key"
  cl_ir_sagemaker_kms_key_retention	= 10

  cl_ir_ebs_kms_key_alias_name		= "cl-ir-lz-ebs"
  cl_ir_ebs_kms_key_description		= "CxLink Ireland Landing Zone ebs Buckets Encryption Custom KMS Key"
  cl_ir_ebs_kms_key_retention		= 10

  cl_ir_s3_kms_key_alias_name		= "cl-ir-lz-s3"
  cl_ir_s3_kms_key_description		= "CxLink Ireland Landing Zone S3 Buckets Encryption Custom KMS Key"
  cl_ir_s3_kms_key_retention		= 10

  cl_ir_ecr_kms_key_alias_name		= "cl-ir-lz-ecr"
  cl_ir_ecr_kms_key_description		= "CxLink Ireland Landing Zone ecr Buckets Encryption Custom KMS Key"
  cl_ir_ecr_kms_key_retention		= 10

  cl_ir_lambda_kms_key_alias_name	= "cl-ir-lz-lambda"
  cl_ir_lambda_kms_key_description	= "CxLink Ireland Landing Zone lambda Buckets Encryption Custom KMS Key"
  cl_ir_lambda_kms_key_retention	= 10

  cl_ir_cloudwatch_kms_key_alias_name	= "cl-ir-lz-cloudwatch"
  cl_ir_cloudwatch_kms_key_description	= "CxLink Ireland Landing Zone cloudwatch Buckets Encryption Custom KMS Key"
  cl_ir_cloudwatch_kms_key_retention	= 10

  cl_ir_rds_kms_key_alias_name		= "cl-ir-lz-rds"
  cl_ir_rds_kms_key_description		= "CxLink Ireland Landing Zone rds Buckets Encryption Custom KMS Key"
  cl_ir_rds_kms_key_retention		= 10

  cl_ir_glue_kms_key_alias_name		= "cl-ir-lz-glue"
  cl_ir_glue_kms_key_description	= "CxLink Ireland Landing Zone glue Buckets Encryption Custom KMS Key"
  cl_ir_glue_kms_key_retention		= 10

}

module "landing-zone_585543526779_eu-west-1_kms" {

  source  = "../../terraform/modules/landing_zone/585543526779/eu-west-1/kms"

  providers = {
            aws.account-585543526779-eu-west-1 = aws.account-585543526779-eu-west-1
  }

  owner					= var.owner
  project				= var.project
  region                                = var.region

  cl_ir_comprehend_kms_key_alias_name		= "cl-ir-lz-comprehend"
  cl_ir_comprehend_kms_key_description		= "CxLink Ireland Landing Zone comprehend Buckets Encryption Custom KMS Key"
  cl_ir_comprehend_kms_key_retention		= 10

  cl_ir_sqs_kms_key_alias_name		= "cl-ir-lz-sqs"
  cl_ir_sqs_kms_key_description		= "CxLink Ireland Landing Zone sqs Buckets Encryption Custom KMS Key"
  cl_ir_sqs_kms_key_retention		= 10

  cl_ir_efs_kms_key_alias_name		= "cl-ir-lz-efs"
  cl_ir_efs_kms_key_description		= "CxLink Ireland Landing Zone efs Buckets Encryption Custom KMS Key"
  cl_ir_efs_kms_key_retention		= 10

  cl_ir_sagemaker_kms_key_alias_name	= "cl-ir-lz-sagemaker"
  cl_ir_sagemaker_kms_key_description	= "CxLink Ireland Landing Zone sagemaker Buckets Encryption Custom KMS Key"
  cl_ir_sagemaker_kms_key_retention	= 10

  cl_ir_ebs_kms_key_alias_name		= "cl-ir-lz-ebs"
  cl_ir_ebs_kms_key_description		= "CxLink Ireland Landing Zone ebs Buckets Encryption Custom KMS Key"
  cl_ir_ebs_kms_key_retention		= 10

  cl_ir_s3_kms_key_alias_name		= "cl-ir-lz-s3"
  cl_ir_s3_kms_key_description		= "CxLink Ireland Landing Zone S3 Buckets Encryption Custom KMS Key"
  cl_ir_s3_kms_key_retention		= 10

  cl_ir_ecr_kms_key_alias_name		= "cl-ir-lz-ecr"
  cl_ir_ecr_kms_key_description		= "CxLink Ireland Landing Zone ecr Buckets Encryption Custom KMS Key"
  cl_ir_ecr_kms_key_retention		= 10

  cl_ir_lambda_kms_key_alias_name	= "cl-ir-lz-lambda"
  cl_ir_lambda_kms_key_description	= "CxLink Ireland Landing Zone lambda Buckets Encryption Custom KMS Key"
  cl_ir_lambda_kms_key_retention	= 10

  cl_ir_cloudwatch_kms_key_alias_name	= "cl-ir-lz-cloudwatch"
  cl_ir_cloudwatch_kms_key_description	= "CxLink Ireland Landing Zone cloudwatch Buckets Encryption Custom KMS Key"
  cl_ir_cloudwatch_kms_key_retention	= 10

  cl_ir_rds_kms_key_alias_name		= "cl-ir-lz-rds"
  cl_ir_rds_kms_key_description		= "CxLink Ireland Landing Zone rds Buckets Encryption Custom KMS Key"
  cl_ir_rds_kms_key_retention		= 10

  cl_ir_glue_kms_key_alias_name		= "cl-ir-lz-glue"
  cl_ir_glue_kms_key_description	= "CxLink Ireland Landing Zone glue Buckets Encryption Custom KMS Key"
  cl_ir_glue_kms_key_retention		= 10

}

module "landing-zone_585543526779_eu-west-1_vpc" {

  source  = "../../terraform/modules/landing_zone/585543526779/eu-west-1/vpc"

  providers = {
            aws.account-585543526779-eu-west-1 = aws.account-585543526779-eu-west-1
  }

  owner					= var.owner
  project				= var.project
  region                                = var.region

  cl_ir_ml_hackathon_vpc_cidr				= "10.0.0.0/16"
  cl_ir_ml_hackathon_vpc_tenancy			= "default"
  cl_ir_ml_hackathon_vpc_dns_enabled			= true
  cl_ir_ml_hackathon_vpc_network_metrics_enabled	= true
  cl_ir_ml_hackathon_vpc_dns_hostnames_enabled		= true
  cl_ir_ml_hackathon_vpc_subet_public_a_cidr		= "10.0.1.0/24"
  cl_ir_ml_hackathon_vpc_subet_public_b_cidr		= "10.0.2.0/24"
  cl_ir_ml_hackathon_vpc_subet_middleware_a_cidr	= "10.0.3.0/24"
  cl_ir_ml_hackathon_vpc_subet_middleware_b_cidr	= "10.0.4.0/24"
  cl_ir_ml_hackathon_vpc_subet_private_a_cidr		= "10.0.5.0/24"
  cl_ir_ml_hackathon_vpc_subet_private_b_cidr		= "10.0.6.0/24"
}

module "landing-zone_585543526779_eu-west-1_iam" {

  source  = "../../terraform/modules/landing_zone/585543526779/eu-west-1/iam"

  providers = {
            aws.account-585543526779-eu-west-1 = aws.account-585543526779-eu-west-1
  }

  owner                                 = var.owner
  project                               = var.project
  region                                = var.region

  cl_ir_ml_hackathon_empathy_aws_iam_read_only_user_name	= "cl-ir-ml-hackathon-empathy-aws-iam-read-only"
  cl_ir_ml_hackathon_empathy_aws_iam_read_only_user_policy_name = "cl-ir-ml-hackathon-empathy-aws-iam-read-only-user"
}
