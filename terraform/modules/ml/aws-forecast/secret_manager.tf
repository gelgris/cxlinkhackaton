resource "aws_secretsmanager_secret" "cl_ir_ml_hackathon_aws_forecast_query_api_key_secret" {

  name = format("${var.cl_ir_ml_hackathon_aws_forecast_api_secret_name}-%s",local.environment[terraform.workspace])
  recovery_window_in_days = "0"

  lifecycle {
    create_before_destroy = true
  }

  tags = local.tags
}

resource "aws_secretsmanager_secret_version" "cl_ir_ml_hackathon_aws_forecast_query_api_lambda_function_api_key_secret_version" {
  secret_id     = aws_secretsmanager_secret.cl_ir_ml_hackathon_aws_forecast_query_api_key_secret.arn
  secret_string = var.cl_ir_ml_hackathon_aws_forecast_api_secret_value
}

data "aws_secretsmanager_secret_version" "cl_ir_ml_hackathon_aws_forecast_query_api_lambda_function_api_key_secret_version" {
  secret_id = aws_secretsmanager_secret.cl_ir_ml_hackathon_aws_forecast_query_api_key_secret.id
  depends_on = [aws_secretsmanager_secret_version.cl_ir_ml_hackathon_aws_forecast_query_api_lambda_function_api_key_secret_version]
}

