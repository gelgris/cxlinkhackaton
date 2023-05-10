resource "aws_athena_workgroup" "cl_ir_ml_hackathon_empathy_quicksight_athena_wg" {
  provider = aws.account-742189430206-eu-west-1

  name =  format("${var.cl_ir_ml_hackathon_empathy_quicksight_athena_wg_name}-%s",local.environment[terraform.workspace])

  configuration {
    enforce_workgroup_configuration    = var.cl_ir_ml_hackathon_empathy_quicksight_athena_wg_enforcing_enabled
    publish_cloudwatch_metrics_enabled = var.cl_ir_ml_hackathon_empathy_quicksight_athena_wg_cloudwatch_metrics_enabled

    result_configuration {
      output_location = format("s3://${var.cl_ir_ml_hackathon_aws_forecast_curated_bucket_name}-%s/${data.aws_caller_identity.current.account_id}/${var.region}/quicksight/",local.environment[terraform.workspace])

      encryption_configuration {
        encryption_option = "SSE_KMS"
        kms_key_arn       = "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_s3_kms_key_id}"
      }
    }
  }
}
