resource "aws_ssm_parameter" "cl_ir_ml_hackathon_mlops_api_secret" {
  name        = format("/%s/api/access_key",local.environment[terraform.workspace])
  description = "CxLink Hakathon Emergencies Forecast API Access Key"
  type        = "SecureString"
  value       = var.cl_ir_ml_hackathon_mlops_api_secret_value

  tags =  local.tags
}
