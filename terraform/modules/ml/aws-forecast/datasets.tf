resource "awscc_forecast_dataset" "cl_ir_ml_hackathon_aws_forecast_dataset_target" {
  for_each = local.cl_ir_ml_hackathon_aws_forecast_target_datasets

  dataset_name	= replace(format("${each.value.dataset_name}_%s_%s",try(each.value.customer_id, ""),local.environment[terraform.workspace]),"-","_")
  lifecycle {
          ignore_changes = [tags]
  }

  dataset_type  = try(each.value.dataset_type, "")
  domain        = try(each.value.dataset_domain, "")

  # item_id, timestamp and demand attributes MUST exist with this name in the target dataset
  schema     =   {
    attributes = [
		{
		"attribute_name":"item_id",
	        "attribute_type" :"string"
		},
		{
		"attribute_name":"workforce_demand",
	        "attribute_type" :"float"
		},
                {
                "attribute_name":"continent",
                "attribute_type" :"string"
                },
                {
                "attribute_name":"country",
                "attribute_type" :"string"
                },
                {
                "attribute_name":"region",
                "attribute_type" :"string"
                },
		{
		"attribute_name":"workforce_type",
	        "attribute_type" :"string"
		},
		{
		"attribute_name":"timestamp",
	        "attribute_type" :"timestamp"
		}
	]
  }

  data_frequency = try(each.value.data_frecuency, "")

  encryption_config = {
    kms_key_arn = "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_s3_kms_key_id}"
    role_arn    = aws_iam_role.cl_ir_ml_hackathon_aws_forecast_role.arn
  }

  tags = [
         {
  	 "key":"Name",
         "value": format("${try(each.value.dataset_name, "")}_%s",local.environment[terraform.workspace])
  	 },
         {
  	 "key":"Environment",
         "value":local.environment[terraform.workspace]
	 },
 	 {
	 "key":"Stage",
         "value": var.stage
	 },
         {
	 "key":"Owner",
         "value": var.owner
	 },
         {
	 "key":"CustomerId",
         "value": try(each.value.customer_id, "")
	 }
	]
}

resource "awscc_forecast_dataset" "cl_ir_ml_hackathon_aws_forecast_dataset_related" {
  for_each = local.cl_ir_ml_hackathon_aws_forecast_related_datasets

  dataset_name	= replace(format("${each.value.dataset_name}_%s_%s",try(each.value.customer_id, ""),local.environment[terraform.workspace]),"-","_")
  lifecycle {
          ignore_changes = [tags]
  }

  dataset_type  = try(each.value.dataset_type, "")
  domain        = try(each.value.dataset_domain, "")

  schema     =   {
    attributes = [
		{
		"attribute_name":"item_id",
	        "attribute_type" :"string"
		},
		{
		"attribute_name":"continent",
	        "attribute_type" :"string"
		},
		{
		"attribute_name":"country",
	        "attribute_type" :"string"
		},
		{
		"attribute_name":"region",
	        "attribute_type" :"string"
		},
		{
		"attribute_name":"language",
	        "attribute_type" :"string"
		},
		{
                "attribute_name":"timestamp",
                "attribute_type" :"timestamp"
                }
	]
  }
  data_frequency = try(each.value.data_frecuency, "")

  encryption_config = {
    kms_key_arn = "arn:aws:kms:${var.region}:${data.aws_caller_identity.current.account_id}:key/${var.cl_ir_s3_kms_key_id}"
    role_arn    = aws_iam_role.cl_ir_ml_hackathon_aws_forecast_role.arn
  }

  tags = [
         {
  	 "key":"Name",
         "value": format("${try(each.value.dataset_name, "")}_%s",local.environment[terraform.workspace])
  	 },
         {
  	 "key":"Environment",
         "value":local.environment[terraform.workspace]
	 },
 	 {
	 "key":"Stage",
         "value": var.stage
	 },
         {
	 "key":"Owner",
         "value": var.owner
	 },
         {
	 "key":"CustomerId",
         "value": try(each.value.customer_id, "")
	 }
	]
}

resource "awscc_forecast_dataset_group" "cl_ir_ml_aws_forecasting_dataset_group" {
  for_each = local.cl_ir_ml_hackathon_aws_forecast_customers

  dataset_group_name    = replace(format("${try(each.value.dataset_group_name, "")}_%s_%s",try(each.value.customer_id, ""),local.environment[terraform.workspace]),"-","_")
  lifecycle {
          ignore_changes = [tags]
  }

  domain                = try(each.value.dataset_group_domain, "")

  dataset_arns          = [
                              #format("arn:aws:forecast:${var.region}:${data.aws_caller_identity.current.account_id}:dataset/${try(each.value.dataset_group_related_name, "")}_%s_%s",replace(try(each.value.customer_id, ""),"-","_"),local.environment[terraform.workspace]),
                              format("arn:aws:forecast:${var.region}:${data.aws_caller_identity.current.account_id}:dataset/${try(each.value.dataset_group_target_name, "")}_%s_%s",replace(try(each.value.customer_id, ""),"-","_"),local.environment[terraform.workspace])
                          ]

  tags = [
         {
         "key":"Name",
         "value": format("${try(each.value.dataset_group_name, "")}_%s",local.environment[terraform.workspace])
         },
         {
         "key":"Environment",
         "value":local.environment[terraform.workspace]
         },
         {
         "key":"Stage",
         "value": var.stage
         },
         {
         "key":"Owner",
         "value": var.owner
         },
         {
         "key":"CustomerId",
         "value": try(each.value.customer_id, "")
         }
        ]
}


