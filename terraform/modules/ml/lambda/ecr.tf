resource "aws_ecr_repository" "cl_ir_ml_hackathon_forecast_lambdas_ecr_repo" {
  for_each 	       = toset(var.cl_ir_ml_hackathon_forecast_lambdas_ecr_repos)
  name                 = format("${each.key}-%s",local.environment[terraform.workspace])
  image_tag_mutability = var.cl_ir_ml_hackathon_forecast_lambdas_ecr_repo_tag_mutability

  # Encryption configuration
  encryption_configuration {
      encryption_type = var.cl_ir_ml_hackathon_forecast_lambdas_ecr_repo_encryption_type
      kms_key         = "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_ecr_kms_key_id}"
  }

  # Image scanning configuration
  image_scanning_configuration {
      scan_on_push = var.cl_ir_ml_hackathon_forecast_lambdas_ecr_repo_scan_on_push
  }

  # Timeouts
  timeouts {
      delete = var.cl_ir_ml_hackathon_forecast_lambdas_ecr_repo_timeout
  }

  # Tags
  tags = local.tags
}
