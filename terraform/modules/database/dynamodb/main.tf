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
}

data "aws_caller_identity" "current" {}

resource "aws_dynamodb_table" "cl_ir_ml_hackathon_empathy_dynamodb" {
  name           = format("${var.cl_ir_ml_hackathon_empathy_dynamodb_name}-%s",local.environment[terraform.workspace])
  billing_mode   = var.cl_ir_ml_hackathon_empathy_dynamodb_billing_mode
  #read_capacity  = var.cl_ir_ml_hackathon_empathy_dynamodb_read_capacity
  #write_capacity = var.cl_ir_ml_hackathon_empathy_dynamodb_write_capacity
  hash_key       = var.cl_ir_ml_hackathon_empathy_dynamodb_hash_key
  #range_key      = var.cl_ir_ml_hackathon_empathy_dynamodb_range_key
  stream_enabled   = var.cl_ir_ml_hackathon_empathy_dynamodb_stream_enabled
  stream_view_type = var.cl_ir_ml_hackathon_empathy_dynamodb_stream_view_type
  table_class 	= var.cl_ir_ml_hackathon_empathy_dynamodb_table_class
  # TODO
  #server_side_encryption {
  #  enabled = true
  #  kms_key_arn = var.
  #}

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "UserName"
    type = "S"
  }

  #attribute {
  #  name = "UserSurname"
  #  type = "S"
  #}

  #attribute {
  #  name = "RecordTimestamp"
  #  type = "N"
  #}

  #ttl {
  #  attribute_name = "RecordTimestamp"
  #  enabled        = false
  #}

  global_secondary_index {
    name               = format("${var.cl_ir_ml_hackathon_empathy_dynamodb_gs_index_name}-%s",local.environment[terraform.workspace])
    hash_key           = "UserId"
    range_key          = "UserName"
    write_capacity     = var.cl_ir_ml_hackathon_empathy_dynamodb_gs_index_write_capacity
    read_capacity      = var.cl_ir_ml_hackathon_empathy_dynamodb_gs_index_read_capacity
    projection_type    = var.cl_ir_ml_hackathon_empathy_dynamodb_gs_index_projection_type
    non_key_attributes = ["UserId"]
  }

  tags = local.tags
}
