# CxLink Hackathon Emapthy Assitant Glue ETL IAM Resources
# TODO: Adjust the glue crawler permissions

resource "aws_iam_role" "cl_ir_ml_hackathon_ea_glue_crawler_role" {
  provider = aws.account-742189430206-eu-west-1

  name = format("${var.cl_ir_ml_hackathon_ea_glue_crawler_role_name}-%s",local.environment[terraform.workspace])
  description = "CxLink Hackathon Emapthy Assitant Glue Role"
  path = "/"
  tags = local.tags

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "SyntaxAWSGlueRoleAssume"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "cl_ir_ml_hackathon_ea_glue_crawler_role_policy" {
  provider = aws.account-742189430206-eu-west-1

  name = format("${var.cl_ir_ml_hackathon_ea_glue_crawler_role_policy_name}-%s",local.environment[terraform.workspace])
  description = "Policiy for the CxLink Hackathon Emapthy Assitant Glue Service"
  path = "/"
  tags = local.tags
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowKMSList",
        "Effect" : "Allow",
        "Action" : [
                "kms:DescribeCustomKeyStores",
                "kms:ListKeys",
                "kms:ListAliases"

        ],
        "Resource" : [
                "*"
         ]
      },
      {
        "Sid" : "AllowKMSAccess",
        "Effect" : "Allow",
        "Action" : [
                "kms:*"
        ],
        "Resource" : [
            "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_cloudwatch_kms_key_id}",
            "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_glue_kms_key_id}",
            "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_s3_kms_key_id}"
         ]
      },
      {
        "Sid" : "AllowGlueAccess",
        "Effect" : "Allow",
        "Action" : [
                "glue:*"
        ],
        "Resource" : [
           "*"
         ]
      },
      {
        "Sid" : "AllowCloudwatchAccess",
        "Effect" : "Allow",
        "Action" : [
                "logs:*"
        ],
        "Resource" : [
           "*"
         ]
      },
      {
        "Sid" : "AllowS3Access",
        "Effect" : "Allow",
        "Action" : [
                "s3:*"
        ],
        "Resource" : [
           "arn:aws:s3:::${format("${var.cl_ir_ml_hackathon_aws_forecast_raw_bucket_name}-%s",local.environment[terraform.workspace])}",
           "arn:aws:s3:::${format("${var.cl_ir_ml_hackathon_aws_forecast_raw_bucket_name}-%s",local.environment[terraform.workspace])}/*"
         ]
      }

     ]
  })
}

resource "aws_iam_role_policy_attachment" "cl_ir_ml_hackathon_ea_glue_crawler_role_policy_attachment" {
  provider = aws.account-742189430206-eu-west-1

  role       = aws_iam_role.cl_ir_ml_hackathon_ea_glue_crawler_role.name
  policy_arn = aws_iam_policy.cl_ir_ml_hackathon_ea_glue_crawler_role_policy.arn
}

# Glue Job IAM Resources

resource "aws_iam_role" "cl_ir_ml_hackathon_ea_glue_job_role" {
  provider = aws.account-742189430206-eu-west-1

  name = format("${var.cl_ir_ml_hackathon_ea_glue_job_role_name}-%s",local.environment[terraform.workspace])
  description = "CxLink Hackathon Emapthy Assitant Glue Role"
  path = "/"
  tags = local.tags

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "SyntaxAWSGlueRoleAssume"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "cl_ir_ml_hackathon_ea_glue_job_role_policy" {
  provider = aws.account-742189430206-eu-west-1

  name = format("${var.cl_ir_ml_hackathon_ea_glue_job_role_policy_name}-%s",local.environment[terraform.workspace])
  description = "Policiy for the CxLink Hackathon Emapthy Assitant Glue Service"
  path = "/"
  tags = local.tags
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowKMSList",
        "Effect" : "Allow",
        "Action" : [
                "kms:DescribeCustomKeyStores",
                "kms:ListKeys",
                "kms:ListAliases"

        ],
        "Resource" : [
                "*"
         ]
      },
      {
        "Sid" : "AllowKMSAccess",
        "Effect" : "Allow",
        "Action" : [
                "kms:*"
        ],
        "Resource" : [
            "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_cloudwatch_kms_key_id}",
            "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_glue_kms_key_id}",
            "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_s3_kms_key_id}"
         ]
      },
      {
        "Sid" : "AllowGlueAccess",
        "Effect" : "Allow",
        "Action" : [
                "glue:*"
        ],
        "Resource" : [
           "*"
         ]
      },
      {
        "Sid" : "AllowCloudwatchAccess",
        "Effect" : "Allow",
        "Action" : [
                "logs:*"
        ],
        "Resource" : [
           "*"
         ]
      },
      {
        "Sid" : "AllowS3Access",
        "Effect" : "Allow",
        "Action" : [
                "s3:*"
        ],
        "Resource" : [

           "arn:aws:s3:::${format("${var.cl_ir_ml_hackathon_aws_forecast_raw_bucket_name}-%s",local.environment[terraform.workspace])}",
           "arn:aws:s3:::${format("${var.cl_ir_ml_hackathon_aws_forecast_raw_bucket_name}-%s",local.environment[terraform.workspace])}/*",
           "arn:aws:s3:::${format("${var.cl_ir_ml_hackathon_aws_forecast_curated_bucket_name}-%s",local.environment[terraform.workspace])}",
           "arn:aws:s3:::${format("${var.cl_ir_ml_hackathon_aws_forecast_curated_bucket_name}-%s",local.environment[terraform.workspace])}/*",
           "arn:aws:s3:::${format("${var.cl_ir_ml_hackathon_ea_glue_bucket_name}-%s",local.environment[terraform.workspace])}",
           "arn:aws:s3:::${format("${var.cl_ir_ml_hackathon_ea_glue_bucket_name}-%s",local.environment[terraform.workspace])}/*"
         ]
      }

     ]
  })
}

resource "aws_iam_role_policy_attachment" "cl_ir_ml_hackathon_ea_glue_job_role_policy_attachment" {
  provider = aws.account-742189430206-eu-west-1

  role       = aws_iam_role.cl_ir_ml_hackathon_ea_glue_job_role.name
  policy_arn = aws_iam_policy.cl_ir_ml_hackathon_ea_glue_job_role_policy.arn
}
