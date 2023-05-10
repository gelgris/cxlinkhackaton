module "cl_hackathon_ea_database" {

  source  = "../../terraform/modules/database/dynamodb"

  owner                                 = var.owner
  project                               = var.project
  region                                = var.region
  vpc_id                                = var.vpc_id
  default_profile                       = var.default_profile
  stage                                 = var.stage
  prefix                                = var.prefix

  cl_ir_ml_hackathon_empathy_dynamodb_name			= "cl-hackathon-empathy-dynamodb"
  cl_ir_ml_hackathon_empathy_dynamodb_billing_mode		= "PAY_PER_REQUEST"
  cl_ir_ml_hackathon_empathy_dynamodb_table_class		= "STANDARD"
  cl_ir_ml_hackathon_empathy_dynamodb_read_capacity		= 20
  cl_ir_ml_hackathon_empathy_dynamodb_write_capacity		= 20
  cl_ir_ml_hackathon_empathy_dynamodb_hash_key			= "UserId"
  cl_ir_ml_hackathon_empathy_dynamodb_range_key			= "UserAge"
  cl_ir_ml_hackathon_empathy_dynamodb_gs_index_name		= "cl-hackathon-empathy-dynamodb-gs-index"
  cl_ir_ml_hackathon_empathy_dynamodb_gs_index_write_capacity	= 10
  cl_ir_ml_hackathon_empathy_dynamodb_gs_index_read_capacity	= 10
  cl_ir_ml_hackathon_empathy_dynamodb_gs_index_projection_type  = "INCLUDE"
  cl_ir_ml_hackathon_empathy_dynamodb_stream_enabled		= true
  cl_ir_ml_hackathon_empathy_dynamodb_stream_view_type		= "NEW_AND_OLD_IMAGES"

}

