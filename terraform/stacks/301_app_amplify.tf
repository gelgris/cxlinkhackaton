module "ml_app_amplify" {

  source  = "../../terraform/modules/app/amplify"

  providers = {
            aws.account-585543526779-eu-west-1 = aws.account-585543526779-eu-west-1,
            aws.account-585543526779-us-east-1 = aws.account-585543526779-us-east-1,
            aws.account-742189430206-eu-west-1 = aws.account-742189430206-eu-west-1,
            aws.account-235641605167-eu-west-1 = aws.account-235641605167-eu-west-1
  }

  owner                                 = var.owner
  project                               = var.project
  region                                = var.region
  vpc_id                                = var.vpc_id
  default_profile                       = var.default_profile
  stage                                 = var.stage
  prefix                                = var.prefix
  cl_ir_s3_kms_key_id                   = var.cl_ir_s3_kms_key_id

  cl_ir_ml_hackathon_app_dev_frontend_bucket_name = "amplify-cxlinkhackathon-dev-153213"
  cl_ir_ml_hackathon_app_prod_frontend_bucket_name = "amplify-cxlinkhackathon-prod-113037"

  cl_ir_ml_hackathon_app_amplify_role_name 	  = "cl-ir-ml-hackathon-app-amplify"
  cl_ir_ml_hackathon_app_amplify_role_policy_name = "cl-ir-ml-hackathon-app-amplify"

  cl_ir_ml_hackathon_app_dev_domain_zone_id       = var.cl_ir_ml_hackathon_app_dev_domain_zone_id
  cl_ir_ml_hackathon_app_prod_domain_zone_id      = var.cl_ir_ml_hackathon_app_prod_domain_zone_id
  cl_ir_ml_hackathon_app_master_domain_name	  = "hackathon.cxlink.syntax.hack"
  cl_ir_ml_hackathon_app_dev_domain_name	  = "hackathon.dev.cxlink.syntax.hack"
  cl_ir_ml_hackathon_app_master_amplify_url	  = "master.d1x588cgnszhv3.amplifyapp.com"
  cl_ir_ml_hackathon_app_dev_amplify_url	  = "development.d1x588cgnszhv3.amplifyapp.com"

  cl_ir_ml_hackathon_app_master_branch_name		= "master"
  cl_ir_ml_hackathon_app_master_branch_display_name	= "master"
  cl_ir_ml_hackathon_app_master_branch_description	= "CxLink Hackathon Emergencies Amplify App Production Environment"
  cl_ir_ml_hackathon_app_master_branch_stage		= "PRODUCTION"
  cl_ir_ml_hackathon_app_master_branch_framework	= "React"

  cl_ir_ml_hackathon_app_development_branch_name		= "development"
  cl_ir_ml_hackathon_app_development_branch_display_name	= "development"
  cl_ir_ml_hackathon_app_development_branch_description		= "CxLink Hackathon Emergencies Amplify App Development Environment"
  cl_ir_ml_hackathon_app_development_branch_stage		= "DEVELOPMENT"
  cl_ir_ml_hackathon_app_development_branch_framework		= "React"

  cl_ir_ml_hackathon_app_master_backend_name	= "prod"
  cl_ir_ml_hackathon_app_master_artifacts	= "amplify-cxlinkhackathon-prod-113037-deployment"
  cl_ir_ml_hackathon_app_master_stack_name	= "amplify-cxlinkhackathon-prod-113037"

  cl_ir_ml_hackathon_app_development_backend_name = "dev"
  cl_ir_ml_hackathon_app_development_artifacts	  = "amplify-cxlinkhackathon-dev-153213-deployment"
  cl_ir_ml_hackathon_app_development_stack_name	  = "amplify-cxlinkhackathon-dev-153213"


  #cl_ir_ml_hackathon_app_name	= "cl-hackathon-emergencies-app"
  cl_ir_ml_hackathon_app_name	= "cxlinkhackathon"
  cl_ir_ml_hackathon_app_repo_name = "cl-ir-ml-hackathon-mlops"

  cl_ir_ml_hackathon_app_auto_branch_creation_enabled	= false
  cl_ir_ml_hackathon_app_basic_auth_enabled		= false
  cl_ir_ml_hackathon_app_branch_auto_build_enabled	= false
  cl_ir_ml_hackathon_app_branch_auto_deletion_enabled	= false
}
