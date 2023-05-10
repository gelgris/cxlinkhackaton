resource "aws_iam_role" "cl_ir_ml_hackathon_aws_forecast_role" {
  name = format("${var.cl_ir_ml_hackathon_aws_forecast_role_name}-%s",local.environment[terraform.workspace])
  description = "CxLink AWS Forecast Lambda Role"
  path = "/"
  tags = local.tags

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "forecast.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "CxLinkAWSForecastRoleAssume"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "cl_ir_ml_hackathon_aws_forecast_role_policy" {
  name = format("${var.cl_ir_ml_hackathon_aws_forecast_role_policy_name}-%s",local.environment[terraform.workspace])
  description = "Policiy for the CxLink AWS Forecast Service"
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
        "Sid" : "AllowForecastAccess",
        "Effect" : "Allow",
        "Action" : [
                "forecast:*"

        ],
        "Resource" : [
                "*"
         ]
      },
      {
        "Sid" : "AllowKMSAccess",
        "Effect" : "Allow",
        "Action" : [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey",
                "kms:CreateGrant",
                "kms:RevokeGrant",
                "kms:RetireGrant",
                "kms:ListGrants"
        ],
        "Resource" : [
           "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_s3_kms_key_id}"
         ]
      }
     ]
  })
}

resource "aws_iam_role_policy_attachment" "cl_ir_ml_hackathon_aws_forecast_role_policy_attachment" {
  role       = aws_iam_role.cl_ir_ml_hackathon_aws_forecast_role.name
  policy_arn = aws_iam_policy.cl_ir_ml_hackathon_aws_forecast_role_policy.arn
}

# Mandatory for AWS Forecast assumed role cause it will need S3 access

resource "aws_iam_role_policy_attachment" "cl_ir_ml_aws_AmazonS3FullAccess_policy_attachment" {
  role       = aws_iam_role.cl_ir_ml_hackathon_aws_forecast_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

