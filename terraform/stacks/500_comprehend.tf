module "empathy_ml_comprehend" {

  source  = "../../terraform/modules/ml/comprehend"

  owner                                 = var.owner
  project                               = var.project
  region                                = var.region
  vpc_id                                = var.vpc_id
  stage                                 = var.stage
  prefix                                = var.prefix

  cl_ir_s3_kms_key_id			= var.cl_ir_s3_kms_key_id
  cl_ir_comprehend_kms_key_id 		= var.cl_ir_comprehend_kms_key_id

  # S3 DataLake Values

  cl_ir_ml_hackathon_aws_forecast_raw_bucket_name		= "cl-ir-ml-hackathon-aws-forecast-raw-bucket-cruz-roja"
  cl_ir_ml_hackathon_aws_forecast_curated_bucket_name		= "cl-ir-ml-hackathon-aws-forecast-curated-bucket-cruz-roja"
  cl_ir_ml_hackathon_aws_comprehend_role_name			= "cl-ir-ml-hackathon-aws-comprehend"
  cl_ir_ml_hackathon_aws_comprehend_role_policy_name		= "cl-ir-ml-hackathon-aws-comprehend"
  cl_ir_ml_hackathon_aws_comprehend_entity_recognizer_name	= "cl-ir-ml-hackathon-aws-comprehend"
  cl_ir_ml_hackathon_aws_comprehend_documents_key 		= "comprehend/documents/documents.json"
  cl_ir_ml_hackathon_aws_comprehend_entities_key 		= "comprehend/entities/entities.json"
}

