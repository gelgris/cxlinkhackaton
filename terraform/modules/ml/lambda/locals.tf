locals {
 cl_ir_ml_hackathon_forecast_dataset_s3_buckets = merge({
    for filename in var.cl_ir_ml_hackathon_forecast_dataset_s3_buckets_files :
      replace(basename(filename), "/\\.(ya?ml|json)$/", "") =>
      length(regexall("\\.ya?ml$", filename)) > 0 ? yamldecode(file(filename)) : jsondecode(file(filename))
    }, var.cl_ir_ml_hackathon_forecast_dataset_s3_buckets)

 cl_ir_ml_hackathon_forecast_customers = merge({
    for filename in var.cl_ir_ml_hackathon_forecast_customers_files :
      replace(basename(filename), "/\\.(ya?ml|json)$/", "") =>
      length(regexall("\\.ya?ml$", filename)) > 0 ? yamldecode(file(filename)) : jsondecode(file(filename))
    }, var.cl_ir_ml_hackathon_forecast_customers)
}

