locals {
  environment = {
    dev   = "dev"
    pre   = "pre"
    prod  = "prod"
    test  = "test"
  }

  tags = {
    environment		= local.environment[terraform.workspace]
    project		= var.project
    owner		= var.owner
  }
}

data "aws_caller_identity" "current" {
  provider = aws.account-585543526779-eu-west-1
}

# CxLink Comprehend Models Encryption Custom KMS Key

resource "aws_kms_alias" "cl_ir_comprehend_kms_key_alias" {
  provider = aws.account-585543526779-eu-west-1
  name          = format("alias/${var.cl_ir_comprehend_kms_key_alias_name}-%s",local.environment[terraform.workspace])
  target_key_id = aws_kms_key.cl_ir_comprehend_kms_key.key_id
}

resource "aws_kms_key" "cl_ir_comprehend_kms_key" {
  provider = aws.account-585543526779-eu-west-1
  description              = var.cl_ir_comprehend_kms_key_description
  deletion_window_in_days  = var.cl_ir_comprehend_kms_key_retention
  key_usage 		   = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  is_enabled 		   = true
  enable_key_rotation 	   = false

  policy = jsonencode({
    "Version": "2012-10-17",
    "Id": "comprehend-kms-access-policy",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow the use of this key",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow the use of this key",
            "Effect": "Allow",
            "Principal": {
                "Service": "sns.amazonaws.com"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow the use of this key",
            "Effect": "Allow",
            "Principal": {
                "Service": "comprehend.amazonaws.com"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow the use of this key",
            "Effect": "Allow",
            "Principal": {
                "Service": "events.amazonaws.com"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        }

    ]
  })

  tags 			   = local.tags
}


# CxLink SQS Encryption Custom KMS Key

resource "aws_kms_alias" "cl_ir_sqs_kms_key_alias" {
  provider = aws.account-585543526779-eu-west-1
  name          = format("alias/${var.cl_ir_sqs_kms_key_alias_name}-%s",local.environment[terraform.workspace])
  target_key_id = aws_kms_key.cl_ir_sqs_kms_key.key_id
}

resource "aws_kms_key" "cl_ir_sqs_kms_key" {
  provider = aws.account-585543526779-eu-west-1
  description              = var.cl_ir_sqs_kms_key_description
  deletion_window_in_days  = var.cl_ir_sqs_kms_key_retention
  key_usage 		   = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  is_enabled 		   = true
  enable_key_rotation 	   = false

  policy = jsonencode({
    "Version": "2012-10-17",
    "Id": "sqs-kms-access-policy",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow the use of this key",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow the use of this key",
            "Effect": "Allow",
            "Principal": {
                "Service": "sns.amazonaws.com"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow the use of this key",
            "Effect": "Allow",
            "Principal": {
                "Service": "sqs.amazonaws.com"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow the use of this key",
            "Effect": "Allow",
            "Principal": {
                "Service": "events.amazonaws.com"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        }

    ]
  })

  tags 			   = local.tags
}


# CxLink EFS Encryption Custom KMS Key

resource "aws_kms_alias" "cl_ir_efs_kms_key_alias" {
  provider = aws.account-585543526779-eu-west-1
  name          = format("alias/${var.cl_ir_efs_kms_key_alias_name}-%s",local.environment[terraform.workspace])
  target_key_id = aws_kms_key.cl_ir_efs_kms_key.key_id
}

resource "aws_kms_key" "cl_ir_efs_kms_key" {
  provider = aws.account-585543526779-eu-west-1
  description              = var.cl_ir_efs_kms_key_description
  deletion_window_in_days  = var.cl_ir_efs_kms_key_retention
  key_usage 		   = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  is_enabled 		   = true
  enable_key_rotation 	   = false

  policy = jsonencode({
    "Version": "2012-10-17",
    "Id": "efs-kms-access-policy",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow the use of this key",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow access from the EFS efs Service",
            "Effect": "Allow",
            "Principal": {
                "Service": "elasticfilesystem.amazonaws.com"
            },
            "Action": [
                "kms:*"
            ],
            "Resource": "*"
        }
    ]
  })

  tags 			   = local.tags
}

# CxLink SageMaker Encryption Custom KMS Key

resource "aws_kms_alias" "cl_ir_sagemaker_kms_key_alias" {
  provider = aws.account-585543526779-eu-west-1
  name          = format("alias/${var.cl_ir_sagemaker_kms_key_alias_name}-%s",local.environment[terraform.workspace])
  target_key_id = aws_kms_key.cl_ir_sagemaker_kms_key.key_id
}

resource "aws_kms_key" "cl_ir_sagemaker_kms_key" {
  provider = aws.account-585543526779-eu-west-1
  description              = var.cl_ir_sagemaker_kms_key_description
  deletion_window_in_days  = var.cl_ir_sagemaker_kms_key_retention
  key_usage 		   = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  is_enabled 		   = true
  enable_key_rotation 	   = false

  policy = jsonencode({
    "Version": "2012-10-17",
    "Id": "sagemaker-kms-access-policy",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow the use of this key",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow access from the AWS SageMaker Service",
            "Effect": "Allow",
            "Principal": {
                "Service": "sagemaker.amazonaws.com"
            },
            "Action": [
                "kms:*"
            ],
            "Resource": "*"
        }
    ]
  })

  tags 			   = local.tags
}

# CxLink S3 Encryption Custom KMS Key

resource "aws_kms_alias" "cl_ir_s3_kms_key_alias" {
  provider = aws.account-585543526779-eu-west-1
  name          = format("alias/${var.cl_ir_s3_kms_key_alias_name}-%s",local.environment[terraform.workspace])
  target_key_id = aws_kms_key.cl_ir_s3_kms_key.key_id
}

resource "aws_kms_key" "cl_ir_s3_kms_key" {
  provider = aws.account-585543526779-eu-west-1
  description              = var.cl_ir_s3_kms_key_description
  deletion_window_in_days  = var.cl_ir_s3_kms_key_retention
  key_usage 		   = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  is_enabled 		   = true
  enable_key_rotation 	   = false

  policy = jsonencode({
    "Version": "2012-10-17",
    "Id": "s3-kms-access-policy",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow the use of this key",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow access from the Amazon S3 Service",
            "Effect": "Allow",
            "Principal": {
                "Service": "s3.${var.region}.amazonaws.com"
            },
            "Action": [
                "kms:Encrypt*",
                "kms:Decrypt*",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:Describe*"
            ],
            "Resource": "*"
        }
    ]
  })

  tags 			   = local.tags
}

# CxLink ebs Encryption Custom KMS Key

resource "aws_kms_alias" "cl_ir_ebs_kms_key_alias" {
  provider = aws.account-585543526779-eu-west-1
  name          = format("alias/${var.cl_ir_ebs_kms_key_alias_name}-%s",local.environment[terraform.workspace])
  target_key_id = aws_kms_key.cl_ir_ebs_kms_key.key_id
}

resource "aws_kms_key" "cl_ir_ebs_kms_key" {
  provider = aws.account-585543526779-eu-west-1
  description              = var.cl_ir_ebs_kms_key_description
  deletion_window_in_days  = var.cl_ir_ebs_kms_key_retention
  key_usage 		   = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  is_enabled 		   = true
  enable_key_rotation 	   = false

  policy = jsonencode({
    "Version": "2012-10-17",
    "Id": "ebs-kms-access-policy",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow the use of this key",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow access from the Amazon ebs Service",
            "Effect": "Allow",
            "Principal": {
                "Service": "ebs.amazonaws.com"
            },
            "Action": [
                "kms:Encrypt*",
                "kms:Decrypt*",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:Describe*"
            ],
            "Resource": "*"
        }
    ]
  })

  tags 			   = local.tags
}

# CxLink ECR Encryption Custom KMS Key

resource "aws_kms_alias" "cl_ir_ecr_kms_key_alias" {
  provider = aws.account-585543526779-eu-west-1
  name          = format("alias/${var.cl_ir_ecr_kms_key_alias_name}-%s",local.environment[terraform.workspace])
  target_key_id = aws_kms_key.cl_ir_ecr_kms_key.key_id
}

resource "aws_kms_key" "cl_ir_ecr_kms_key" {
  provider = aws.account-585543526779-eu-west-1
  description              = var.cl_ir_ecr_kms_key_description
  deletion_window_in_days  = var.cl_ir_ecr_kms_key_retention
  key_usage 		   = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  is_enabled 		   = true
  enable_key_rotation 	   = false

  policy = jsonencode({
    "Version": "2012-10-17",
    "Id": "ecr-kms-access-policy",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow the use of this key",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        }
    ]
  })

  tags 			   = local.tags
}

# CxLink CloudWatch Logs Encryption Custom KMS Key

resource "aws_kms_alias" "cl_ir_cloudwatch_kms_key_alias" {
  provider = aws.account-585543526779-eu-west-1
  name          = format("alias/${var.cl_ir_cloudwatch_kms_key_alias_name}-%s",local.environment[terraform.workspace])
  target_key_id = aws_kms_key.cl_ir_cloudwatch_kms_key.key_id
}

resource "aws_kms_key" "cl_ir_cloudwatch_kms_key" {
  provider = aws.account-585543526779-eu-west-1
  description              = var.cl_ir_cloudwatch_kms_key_description
  deletion_window_in_days  = var.cl_ir_cloudwatch_kms_key_retention
  key_usage 		   = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  is_enabled 		   = true
  enable_key_rotation 	   = false

  policy = jsonencode({
    "Version": "2012-10-17",
    "Id": "cloudwatch-kms-access-policy",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow the use of this key",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow access from the AWS CloudWatch Logs Service",
            "Effect": "Allow",
            "Principal": {
                "Service": "logs.${var.region}.amazonaws.com"
            },
            "Action": [
                "kms:Encrypt*",
                "kms:Decrypt*",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:Describe*"
            ],
            "Resource": "*",
            "Condition": {
                "ArnLike": {
                    "kms:EncryptionContext:aws:logs:arn": "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:*"
                }
            }
        }
    ]
  })

  tags 			   = local.tags
}

# CxLink Lambda Encryption Custom KMS Key

resource "aws_kms_alias" "cl_ir_lambda_kms_key_alias" {
  provider = aws.account-585543526779-eu-west-1
  name          = format("alias/${var.cl_ir_lambda_kms_key_alias_name}-%s",local.environment[terraform.workspace])
  target_key_id = aws_kms_key.cl_ir_lambda_kms_key.key_id
}

resource "aws_kms_key" "cl_ir_lambda_kms_key" {
  provider = aws.account-585543526779-eu-west-1
  description              = var.cl_ir_lambda_kms_key_description
  deletion_window_in_days  = var.cl_ir_lambda_kms_key_retention
  key_usage 		   = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  is_enabled 		   = true
  enable_key_rotation 	   = false

  policy = jsonencode({
    "Version": "2012-10-17",
    "Id": "lambda-kms-access-policy",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow the use of this key",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow access from the AWS Lambda Service",
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.${var.region}.amazonaws.com"
            },
            "Action": [
                "kms:Encrypt*",
                "kms:Decrypt*",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:Describe*"
            ],
            "Resource": "*"
        }
    ]
  })

  tags 			   = local.tags
}

# CxLink RDS Encryption Custom KMS Key

resource "aws_kms_alias" "cl_ir_rds_kms_key_alias" {
  provider = aws.account-585543526779-eu-west-1
  name          = format("alias/${var.cl_ir_rds_kms_key_alias_name}-%s",local.environment[terraform.workspace])
  target_key_id = aws_kms_key.cl_ir_rds_kms_key.key_id
}

resource "aws_kms_key" "cl_ir_rds_kms_key" {
  provider = aws.account-585543526779-eu-west-1
  description              = var.cl_ir_rds_kms_key_description
  deletion_window_in_days  = var.cl_ir_rds_kms_key_retention
  key_usage 		   = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  is_enabled 		   = true
  enable_key_rotation 	   = false

  policy = jsonencode({
    "Version": "2012-10-17",
    "Id": "rds-kms-access-policy",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow the use of this key",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        }
        #{
        #    "Sid": "Allow access from the AWS rds Service",
        #    "Effect": "Allow",
        #    "Principal": {
        #        "Service": "rds.${var.region}.amazonaws.com"
        #    },
        #    "Action": [
        #        "kms:Encrypt*",
        #        "kms:Decrypt*",
        #        "kms:ReEncrypt*",
        #        "kms:GenerateDataKey*",
        #        "kms:Describe*"
        #    ],
        #    "Resource": "*"
        #}
    ]
  })

  tags 			   = local.tags
}

# CxLink Glue Encryption Custom KMS Key

resource "aws_kms_alias" "cl_ir_glue_kms_key_alias" {
  provider = aws.account-585543526779-eu-west-1
  name          = format("alias/${var.cl_ir_glue_kms_key_alias_name}-%s",local.environment[terraform.workspace])
  target_key_id = aws_kms_key.cl_ir_glue_kms_key.key_id
}

resource "aws_kms_key" "cl_ir_glue_kms_key" {
  provider = aws.account-585543526779-eu-west-1
  description              = var.cl_ir_glue_kms_key_description
  deletion_window_in_days  = var.cl_ir_glue_kms_key_retention
  key_usage 		   = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  is_enabled 		   = true
  enable_key_rotation 	   = false

  policy = jsonencode({
    "Version": "2012-10-17",
    "Id": "glue-kms-access-policy",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow the use of this key",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow access from the AWS Glue Service",
            "Effect": "Allow",
            "Principal": {
                "Service": "glue.${var.region}.amazonaws.com"
            },
            "Action": [
                "kms:*"
            ],
            "Resource": "*"
        }
    ]
  })

  tags 			   = local.tags
}



