# CxLink Global Variables

variable "prefix" {
  type = string
  description = "CxLink Infrastructure Prefix"
  default = "cl"
}

variable "owner" {
  type = string
  description = "Owner Tag Value"
}

variable "project" {
  type = string
  description = "Project Tag Value"
}

variable "region" {
  type = string
  description = "AWS Default Region"
  default = "eu-west-1"
}

variable "vpc_id" {
  type = string
  description = "AWS VPC ID"
}

variable "default_profile" {
  type = string
  description = "AWS CLI Default Profile"
  default = "terraform-ml-prod"
}

variable "stage" {
  type = string
  description = "Project Stage (project or ongoing)"
  default = "project"
}

# CxLink Empathy DynamoDB Values

variable "cl_ir_ml_hackathon_empathy_dynamodb_name" {
  type = string
  description = "CxLink Hackathon Empathy DynamoDB Name"
}

variable "cl_ir_ml_hackathon_empathy_dynamodb_billing_mode" {
  type = string
  description = "CxLink Hackathon Empathy DynamoDB Billing Mode"
}

variable "cl_ir_ml_hackathon_empathy_dynamodb_read_capacity" {
  type = number
  description = "CxLink Hackathon Empathy DynamoDB Read Capacity"
}

variable "cl_ir_ml_hackathon_empathy_dynamodb_write_capacity" {
  type = number
  description = "CxLink Hackathon Empathy DynamoDB Write Capacity"
}

variable "cl_ir_ml_hackathon_empathy_dynamodb_hash_key" {
  type = string
  description = "CxLink Hackathon Empathy DynamoDB Hash Key"
}

variable "cl_ir_ml_hackathon_empathy_dynamodb_gs_index_name" {
  type = string
  description = "CxLink Hackathon Empathy DynamoDB Index Name"
}

variable "cl_ir_ml_hackathon_empathy_dynamodb_gs_index_write_capacity" {
  type = number
  description = "CxLink Hackathon Empathy DynamoDB Global Secondary Index Write Capacity"
}

variable "cl_ir_ml_hackathon_empathy_dynamodb_gs_index_read_capacity" {
  type = number
  description = "CxLink Hackathon Empathy DynamoDB Global Secondary Index Read Capacity"
}

variable "cl_ir_ml_hackathon_empathy_dynamodb_gs_index_projection_type" {
  type = string
  description = "CxLink Hackathon Empathy DynamoDB Global Secondary Index Projection Type"
}

variable "cl_ir_ml_hackathon_empathy_dynamodb_stream_enabled" {
  type = bool
  description = "Whether If the CxLink Hackathon Empathy DynamoDB Stream is Enabled or Not"
}

variable "cl_ir_ml_hackathon_empathy_dynamodb_stream_view_type" {
  type = string
  description = "CxLink Hackathon Empathy DynamoDB Stream View Type"
}

variable "cl_ir_ml_hackathon_empathy_dynamodb_table_class" {
  type = string
  description = "CxLink Hackathon Empathy DynamoDB Stream Table Class"
}

variable "cl_ir_ml_hackathon_empathy_dynamodb_range_key" {
  type = string
  description = "CxLink Hackathon Empathy DynamoDB Range Key"
}


