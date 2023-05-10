resource "aws_iam_role" "cl_ir_ml_hackathon_mlops_pipeline_role" {
  name = format("${var.cl_ir_ml_hackathon_mlops_pipeline_role_name}-%s",local.environment[terraform.workspace])
  description = "CxLink AWS Forecast MLOps Piepeline Role"
  path = "/"
  tags = local.tags

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "CxLinkAWSCodepipelineRoleAssume"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "cl_ir_ml_hackathon_mlops_pipeline_role_policy" {
  name = format("${var.cl_ir_ml_hackathon_mlops_pipeline_role_policy_name}-%s",local.environment[terraform.workspace])
  description = "Policiy for the CxLink AWS Forecast MLOps Pipelines"
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
            "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_s3_kms_key_id}"
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
        "Sid" : "AllowSSMAccess",
        "Effect" : "Allow",
        "Action" : [
                "ssm:GetParameters"
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
                        "cloudformation.amazonaws.com",
			"forecast.amazonaws.com",
                        "elasticbeanstalk.amazonaws.com",
                        "ec2.amazonaws.com",
                        "ecs-tasks.amazonaws.com"
                    ]
                }
            }
      },
      {
            "Action": [
                "codecommit:CancelUploadArchive",
                "codecommit:GetBranch",
                "codecommit:GetCommit",
                "codecommit:GetRepository",
                "codecommit:GetUploadArchiveStatus",
                "codecommit:UploadArchive"
            ],
            "Resource": "*",
            "Effect": "Allow"
      },
      {
            "Action": [
                "codestar-connections:UseConnection"
            ],
            "Resource": "*",
            "Effect": "Allow"
      },
      {
            "Action": [
                "elasticbeanstalk:*",
                "ec2:*",
                "elasticloadbalancing:*",
                "autoscaling:*",
                "cloudwatch:*",
                "s3:*",
                "sns:*",
                "cloudformation:*",
                "rds:*",
                "sqs:*",
                "ecs:*"
            ],
            "Resource": "*",
            "Effect": "Allow"
      },
      {
            "Action": [
                "lambda:InvokeFunction",
                "lambda:ListFunctions"
            ],
            "Resource": "*",
            "Effect": "Allow"
      },
      {
            "Action": [
                "opsworks:CreateDeployment",
                "opsworks:DescribeApps",
                "opsworks:DescribeCommands",
                "opsworks:DescribeDeployments",
                "opsworks:DescribeInstances",
                "opsworks:DescribeStacks",
                "opsworks:UpdateApp",
                "opsworks:UpdateStack"
            ],
            "Resource": "*",
            "Effect": "Allow"
      },
      {
            "Action": [
                "cloudformation:CreateStack",
                "cloudformation:DeleteStack",
                "cloudformation:DescribeStacks",
                "cloudformation:UpdateStack",
                "cloudformation:CreateChangeSet",
                "cloudformation:DeleteChangeSet",
                "cloudformation:DescribeChangeSet",
                "cloudformation:ExecuteChangeSet",
                "cloudformation:SetStackPolicy",
                "cloudformation:ValidateTemplate"
            ],
            "Resource": "*",
            "Effect": "Allow"
      },
      {
            "Action": [
                "codedeploy:CreateDeployment",
                "codedeploy:GetApplication",
                "codedeploy:GetApplicationRevision",
                "codedeploy:GetDeployment",
                "codedeploy:GetDeploymentConfig",
                "codedeploy:RegisterApplicationRevision"
            ],
            "Resource": "*",
            "Effect": "Allow"
      },
      {
      "Effect": "Allow",
      "Action": [
         "codecommit:GitPull",
         "codecommit:GitPush",
         "codecommit:GetBranch",
         "codecommit:CreateCommit",
         "codecommit:ListRepositories",
         "codecommit:BatchGetCommits",
         "codecommit:BatchGetRepositories",
         "codecommit:GetCommit",
         "codecommit:GetRepository",
         "codecommit:GetUploadArchiveStatus",
         "codecommit:ListBranches",
         "codecommit:UploadArchive"
      ],
      "Resource":  aws_codecommit_repository.cl_ir_ml_hackathon_mlops_pipeline_repo.arn
      },
      {
            "Effect": "Allow",
            "Action": [
                "devicefarm:ListProjects",
                "devicefarm:ListDevicePools",
                "devicefarm:GetRun",
                "devicefarm:GetUpload",
                "devicefarm:CreateUpload",
                "devicefarm:ScheduleRun"
            ],
            "Resource": "*"
      },
      { 
            "Effect": "Allow",
            "Action": [
                "appconfig:StartDeployment",
                "appconfig:StopDeployment",
                "appconfig:GetDeployment"
            ],
            "Resource": "*"
      },
      {
            "Effect": "Allow",
            "Action": [
                "states:DescribeExecution",
                "states:DescribeStateMachine",
                "states:StartExecution"
            ],
            "Resource": "*"
      },
      {
            "Effect": "Allow",
            "Action": [
                "ecr:DescribeImages"
            ],
            "Resource": "*"
      },
      {
            "Effect": "Allow",
            "Action": [
                "cloudformation:ValidateTemplate"
            ],
            "Resource": "*"
      },
      {
            "Effect": "Allow",
            "Action": [
                "servicecatalog:ListProvisioningArtifacts",
                "servicecatalog:CreateProvisioningArtifact",
                "servicecatalog:DescribeProvisioningArtifact",
                "servicecatalog:DeleteProvisioningArtifact",
                "servicecatalog:UpdateProduct"
            ],
            "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuild",
          "codebuild:BatchGetBuildBatches",
          "codebuild:StartBuildBatch",
          "codebuild:BatchGetProjects"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuild"
        ],
        "Resource": "*"
      },
      {
      "Effect": "Allow",
      "Action": [
        "codebuild:CreateReportGroup",
        "codebuild:CreateReport",
        "codebuild:UpdateReport",
        "codebuild:BatchPutTestCases"
      ],
      "Resource": "*"
      },
      {
        "Sid" : "AllowS3Access",
        "Effect" : "Allow",
        "Action" : [
                "s3:*"
        ],
        "Resource" : [
           "arn:aws:s3:::${format("${var.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_name}-%s",local.environment[terraform.workspace])}",
           "arn:aws:s3:::${format("${var.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_name}-%s",local.environment[terraform.workspace])}/*"
         ]
      }

     ]
  })
}

resource "aws_iam_role_policy_attachment" "cl_ir_ml_hackathon_mlops_pipeline_role_policy_attachment" {
  role       = aws_iam_role.cl_ir_ml_hackathon_mlops_pipeline_role.name
  policy_arn = aws_iam_policy.cl_ir_ml_hackathon_mlops_pipeline_role_policy.arn
}

# MLOps CodeBuils IAM Resources

resource "aws_iam_role" "cl_ir_ml_hackathon_mlops_pipeline_codebuild_role" {
  name = format("${var.cl_ir_ml_hackathon_mlops_pipeline_codebuild_role_name}-%s",local.environment[terraform.workspace])
  description = "CxLink AWS Forecast MLOps Pipeline CodeBuild Role"
  path = "/"
  tags = local.tags

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "CxLinkAWSCodeBuilsRoleAssume"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "cl_ir_ml_hackathon_mlops_pipeline_codebuild_role_policy" {
  name = format("${var.cl_ir_ml_hackathon_mlops_pipeline_codebuild_role_policy_name}-%s",local.environment[terraform.workspace])
  description = "Policiy for the CxLink AWS Forecast CodeBuild Service"
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
            "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_s3_kms_key_id}"
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
                        "cloudformation.amazonaws.com",
			"forecast.amazonaws.com",
                        "codebuild.amazonaws.com",
                        "elasticbeanstalk.amazonaws.com",
                        "ec2.amazonaws.com",
                        "ecs-tasks.amazonaws.com"
                    ]
                }
            }
      },
      {
        "Sid" : "AllowSSMAccess",
        "Effect" : "Allow",
        "Action" : [
                "ssm:GetParameters"
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
           "arn:aws:s3:::${format("${var.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_name}-%s",local.environment[terraform.workspace])}",
           "arn:aws:s3:::${format("${var.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_name}-%s",local.environment[terraform.workspace])}/*",
           "arn:aws:s3:::${format("${var.cl_ir_ml_hackathon_aws_forecast_raw_bucket_name}-%s",local.environment[terraform.workspace])}",
           "arn:aws:s3:::${format("${var.cl_ir_ml_hackathon_aws_forecast_raw_bucket_name}-%s",local.environment[terraform.workspace])}/*",
           "arn:aws:s3:::${format("${var.cl_ir_ml_hackathon_aws_forecast_curated_bucket_name}-%s",local.environment[terraform.workspace])}",
           "arn:aws:s3:::${format("${var.cl_ir_ml_hackathon_aws_forecast_curated_bucket_name}-%s",local.environment[terraform.workspace])}/*"
         ]
      }
     ]
  })
}

resource "aws_iam_role_policy_attachment" "cl_ir_ml_hackathon_mlops_pipeline_codebuild_role_policy_attachment" {
  role       = aws_iam_role.cl_ir_ml_hackathon_mlops_pipeline_codebuild_role.name
  policy_arn = aws_iam_policy.cl_ir_ml_hackathon_mlops_pipeline_codebuild_role_policy.arn
}

