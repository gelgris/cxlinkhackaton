
# CxLink Hackathon Empathy Assistant Filter Lambda Function Resources

data "external" "cl_ir_hackathon_empathy_filter_lambda_hash" {
  program = ["./src/hash.sh", "./src/lambdas/${var.cl_ir_hackathon_empathy_filter_lambda_function_name}/"]
}

# Build and push the Docker image whenever the hash changes

resource "null_resource" "cl_ir_hackathon_empathy_filter_lambda_push" {
  triggers = {
    hash = data.external.cl_ir_hackathon_empathy_filter_lambda_hash.result["hash"]
  }

  provisioner "local-exec" {
    command     = "${"./src/push.sh"} ${var.region} ${local.environment[terraform.workspace]} ${var.default_profile} ${var.cl_ir_hackathon_empathy_filter_lambda_function_name} ${format("%s_%s_%s", var.cl_ir_hackathon_empathy_filter_lambda_function_name, var.stage, local.environment[terraform.workspace])} ${var.stage} ${data.aws_caller_identity.current.account_id} ./src/lambdas/${var.cl_ir_hackathon_empathy_filter_lambda_function_name}/"
    interpreter = ["bash", "-c"]
  }
}

data "aws_ecr_image" "cl_ir_hackathon_empathy_filter_lambda_docker_image" {

  repository_name =  format("${var.cl_ir_hackathon_empathy_filter_lambda_ecr_repo}-%s", local.environment[terraform.workspace])
  image_tag       = "latest"
  depends_on =[null_resource.cl_ir_hackathon_empathy_filter_lambda_push]

}

resource "aws_lambda_function" "cl_ir_hackathon_empathy_filter_lambda" {
  function_name = format("${var.cl_ir_hackathon_empathy_filter_lambda_function_name}-%s",local.environment[terraform.workspace])
  architectures = var.cl_ir_ml_hackathon_forecast_lambda_architecture
  # Only if you want to switch to Zib based deployment
  # handler       = var.cl_ir_hackathon_empathy_filter_lambda_handler
  # runtime       = var.cl_ir_hackathon_empathy_filter_lambda_runtime
  role          = aws_iam_role.cl_ir_hackathon_empathy_filter_lambda_role.arn
  timeout       = var.cl_ir_hackathon_empathy_filter_lambda_timeout
  package_type  = var.cl_ir_hackathon_empathy_filter_lambda_package_type
  memory_size   = var.cl_ir_hackathon_empathy_filter_lambda_memory
  description   = var.cl_ir_hackathon_empathy_filter_lambda_description
  publish       = var.cl_ir_hackathon_empathy_filter_lambda_function_publish_enabled
  reserved_concurrent_executions = var.cl_ir_hackathon_empathy_filter_lambda_function_concurrency

  kms_key_arn           = "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_lambda_kms_key_id}"

  ephemeral_storage {
    size = var.cl_ir_hackathon_empathy_filter_lambda_function_ephemeral_size
  }

  # We dont use a DLQ, this is a synchronous lambda function

  #dead_letter_config {
  #  target_arn = aws_sqs_queue.cl_ir_hackathon_empathy_filter_lambda_sqs_dlq.arn
  #}

  # We dont need VPC in this moment

  #vpc_config{
  #  security_group_ids = [aws_security_group.cl_ir_hackathon_empathy_filter_lambda_security_group.id]
  #  subnet_ids         = var.cl_ir_hackathon_empathy_filter_lambda_subnet_ids
  #}

  environment   {
    variables = {
         ENVIRONMENT_TAG = local.environment[terraform.workspace],
         OWNER_TAG       = var.owner,
         STAGE_TAG       = var.stage,
         PROJECT_TAG     = var.project,
         REGION          = var.region,
         PREFIX          = var.prefix
    }
  }

 image_uri = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.cl_ir_hackathon_empathy_filter_lambda_function_name}-lambda-${local.environment[terraform.workspace]}:latest"

  tags          = local.tags
  depends_on = [
    aws_iam_role.cl_ir_hackathon_empathy_filter_lambda_role
  ]
}

resource "aws_lambda_alias" "cl_ir_hackathon_empathy_filter_lambda_alias" {
  name             = format("${var.cl_ir_hackathon_empathy_filter_lambda_alias_name}-%s",local.environment[terraform.workspace])
  description      = var.cl_ir_hackathon_empathy_filter_lambda_alias_description
  function_name    = aws_lambda_function.cl_ir_hackathon_empathy_filter_lambda.function_name
  function_version = "$LATEST"
}

resource "aws_sns_topic" "cl_ir_hackathon_empathy_filter_lambda_sns_topic" {
  name = format("${var.cl_ir_hackathon_empathy_filter_lambda_sns_topic_name}-%s",local.environment[terraform.workspace])
  display_name = var.cl_ir_hackathon_empathy_filter_lambda_sns_topic_name
  tags = local.tags
}

# Security Groups

resource "aws_security_group" "cl_ir_hackathon_empathy_filter_lambda_security_group" {
  name = format("${var.cl_ir_hackathon_empathy_filter_lambda_security_group_name}-%s",local.environment[terraform.workspace])

  description = "CxLink AWS Forecast Lambda Security Group"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}

# IAM

resource "aws_iam_role" "cl_ir_hackathon_empathy_filter_lambda_role" {
  name = format("${var.cl_ir_hackathon_empathy_filter_lambda_role_name}-%s",local.environment[terraform.workspace])
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
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "CxLinkAWSForecastLambdaRoleAssume"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "cl_ir_hackathon_empathy_filter_lambda_role_policy" {
  name = format("${var.cl_ir_hackathon_empathy_filter_lambda_role_policy_name}-%s",local.environment[terraform.workspace])
  description = "Policiy for the CxLink AWS Forecast Lambda Function"
  path = "/"
  tags = local.tags
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowKMSAccess",
        "Effect" : "Allow",
        "Action" : [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"

        ],
        "Resource" : [

           "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_s3_kms_key_id}"

         ]
        },
	{
        "Sid" : "AllowDynamoDB",
        "Effect" : "Allow",
        "Action" : [
          "dynamodb:*"
        ],
        "Resource" : [
          "*"
         ]
      },
      {
        "Sid" : "AllowTranscribe",
        "Effect" : "Allow",
        "Action" : [
             "transcribe:*"
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
            "Action": [
                "iam:PassRole"
            ],
            "Resource": "*",
            "Effect": "Allow",
            "Condition": {
                "StringEqualsIfExists": {
                    "iam:PassedToService": [
                        "comprehend.amazonaws.com"
                    ]
                }
            }
        },
	{
        "Sid" : "AllowDescribeDataSets",
        "Effect" : "Allow",
        "Action" : [
                "forecast:DescribeDatasetGroup"
        ],
        "Resource" : [
                        "*"
         ]
      },
	{
        "Sid" : "AllowListTagsForecast",
        "Effect" : "Allow",
        "Action" : [
                "forecast:ListTagsForResource"
        ],
        "Resource" : [
                        "*"
         ]
      },

      {
        "Sid" : "AllowcQueryForecast",
        "Effect" : "Allow",
        "Action" : [
                "forecast:QueryForecast",
		"forecast:QueryWhatIfForecast"

        ],
        "Resource" : [
                        "arn:aws:forecast:${var.region}:${data.aws_caller_identity.current.account_id}:forecast/*",
                        "arn:aws:forecast:${var.region}:${data.aws_caller_identity.current.account_id}:what-if-forecast/*"
         ]
      },
      {
        "Sid" : "AllowSendAmazonSESEmails",
        "Effect" : "Allow",
        "Action" : [
                "ses:SendEmail",
                "ses:SendTemplatedEmail",
                "ses:SendRawEmail"

        ],
        "Resource" : [
                "arn:aws:ses:${var.region}:${data.aws_caller_identity.current.account_id}:identity/*",
                "arn:aws:ses:${var.region}:${data.aws_caller_identity.current.account_id}:template/*",
                "arn:aws:ses:${var.region}:${data.aws_caller_identity.current.account_id}:configuration-set/*"
         ]
      },
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

        "Sid" : "AllowSelfInvoke",
        "Effect" : "Allow",
        "Action" : [
              "lambda:Invoke",

        ],
        "Resource" : aws_lambda_function.cl_ir_hackathon_empathy_filter_lambda.arn
      },
      {
        "Sid" : "AllowXRay",
        "Effect" : "Allow",
        "Action" : [
              "xray:PutTraceSegments",
              "xray:PutTelemetryRecords"

        ],
        "Resource" : "*"
      },
      {
        "Sid" : "AllowCloudWatchLogsAccess",
        "Effect" : "Allow",
        "Action" : [
		"logs:CreateLogGroup",
		"logs:CreateLogStream",
		"logs:PutLogEvents"
        ],
        "Resource" : [
               "arn:aws:s3:::logs:*:*:*"
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
	       format("arn:aws:s3:::${var.cl_ir_ml_hackathon_forecasting_raw_bucket_name}-%s",local.environment[terraform.workspace]),
               format("arn:aws:s3:::${var.cl_ir_ml_hackathon_forecasting_raw_bucket_name}-%s/*",local.environment[terraform.workspace]),
               format("arn:aws:s3:::${var.cl_ir_ml_hackathon_forecasting_curated_bucket_name}-%s",local.environment[terraform.workspace]),
               format("arn:aws:s3:::${var.cl_ir_ml_hackathon_forecasting_curated_bucket_name}-%s/*",local.environment[terraform.workspace])
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
         ]      }
     ]
  })
}

resource "aws_iam_role_policy_attachment" "cl_ir_hackathon_empathy_filter_lambda_role_policy_attachment" {
  role       = aws_iam_role.cl_ir_hackathon_empathy_filter_lambda_role.name
  policy_arn = aws_iam_policy.cl_ir_hackathon_empathy_filter_lambda_role_policy.arn
}

resource "aws_iam_role_policy_attachment" "cl_ir_hackathon_empathy_filter_lambda_role_basic_execution_policy_attachment" {
  role       = aws_iam_role.cl_ir_hackathon_empathy_filter_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "cl_ir_hackathon_empathy_filter_lambda_vpc_basic_execution_polciy_attachment" {
  role       = aws_iam_role.cl_ir_hackathon_empathy_filter_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}
