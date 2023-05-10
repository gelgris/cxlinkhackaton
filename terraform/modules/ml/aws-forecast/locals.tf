locals {

  environment = {
    dev   = "dev"
    pre   = "pre"
    prod  = "prod"
    test  = "test"
  }

  tags = {
    environment         = local.environment[terraform.workspace]
    project             = var.project
    owner               = var.owner
    stage               = var.stage
  }

  cl_ir_ml_hackathon_aws_forecast_target_datasets = merge({
    for filename in var.cl_ir_ml_hackathon_aws_forecast_target_datasets_files :
      replace(basename(filename), "/\\.(ya?ml|json)$/", "") =>
      length(regexall("\\.ya?ml$", filename)) > 0 ? yamldecode(file(filename)) : jsondecode(file(filename))
    }, var.cl_ir_ml_hackathon_aws_forecast_target_datasets)

  cl_ir_ml_hackathon_aws_forecast_related_datasets = merge({
    for filename in var.cl_ir_ml_hackathon_aws_forecast_related_datasets_files :
      replace(basename(filename), "/\\.(ya?ml|json)$/", "") =>
      length(regexall("\\.ya?ml$", filename)) > 0 ? yamldecode(file(filename)) : jsondecode(file(filename))
    }, var.cl_ir_ml_hackathon_aws_forecast_related_datasets)

  cl_ir_ml_hackathon_aws_forecast_customers = merge({
    for filename in var.cl_ir_ml_hackathon_aws_forecast_customers_files :
      replace(basename(filename), "/\\.(ya?ml|json)$/", "") =>
      length(regexall("\\.ya?ml$", filename)) > 0 ? yamldecode(file(filename)) : jsondecode(file(filename))
    }, var.cl_ir_ml_hackathon_aws_forecast_customers)
}


