resource "aws_iam_role" "cl_ir_ml_hackathon_aws_comprehend_role" {
  name = format("${var.cl_ir_ml_hackathon_aws_comprehend_role_name}-%s",local.environment[terraform.workspace])
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
        "Service": "comprehend.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "CxLinkAWSComprehendtRoleAssume"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "cl_ir_ml_hackathon_aws_comprehend_role_policy" {
  name = format("${var.cl_ir_ml_hackathon_aws_comprehend_role_policy_name}-%s",local.environment[terraform.workspace])
  description = "Policiy for the CxLink Comprehend Service"
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
        "Sid" : "AllowComprehend",
        "Effect" : "Allow",
        "Action" : [
                "comprehend:*"

        ],
        "Resource" : [
                "*"
         ]
      },
      {
        "Sid" : "AllowS3ReadWriteAccess",
        "Effect" : "Allow",
        "Action" : [
                "s3:PutObject",
                "s3:GetObjectAcl",
                "s3:GetObject",
                "s3:ListBucket",
                "s3:DeleteObject",
                "s3:PutObjectAcl",
                "s3:GetObjectTagging"
        ],
        "Resource" : [
               format("arn:aws:s3:::${var.cl_ir_ml_hackathon_aws_forecast_raw_bucket_name}-%s",local.environment[terraform.workspace]),
               format("arn:aws:s3:::${var.cl_ir_ml_hackathon_aws_forecast_raw_bucket_name}-%s/*",local.environment[terraform.workspace]),
               format("arn:aws:s3:::${var.cl_ir_ml_hackathon_aws_forecast_curated_bucket_name}-%s",local.environment[terraform.workspace]),
               format("arn:aws:s3:::${var.cl_ir_ml_hackathon_aws_forecast_curated_bucket_name}-%s/*",local.environment[terraform.workspace])
         ]
      },
      {
        "Sid" : "AllowS3ListAndGetAclsofAllBuckets",
        "Effect" : "Allow",
        "Action" : [
                "s3:ListAllMyBuckets",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
        ],
        "Resource" : [
           "arn:aws:s3:::*"
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

resource "aws_iam_role_policy_attachment" "cl_ir_ml_hackathon_aws_comprehend_role_policy_attachment" {
  role       = aws_iam_role.cl_ir_ml_hackathon_aws_comprehend_role.name
  policy_arn = aws_iam_policy.cl_ir_ml_hackathon_aws_comprehend_role_policy.arn
}

