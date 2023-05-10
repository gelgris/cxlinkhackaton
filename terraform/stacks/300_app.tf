module "ml_app_auth" {

  source  = "../../terraform/modules/app/auth"

  providers = {
            aws.account-585543526779-eu-west-1 = aws.account-585543526779-eu-west-1,
            aws.account-585543526779-us-east-1 = aws.account-585543526779-us-east-1,
            aws.account-742189430206-eu-west-1 = aws.account-742189430206-eu-west-1
  }

  owner                                 = var.owner
  project                               = var.project
  region                                = var.region
  vpc_id                                = var.vpc_id
  default_profile                       = var.default_profile
  stage                                 = var.stage
  prefix                                = var.prefix

  cl_ir_ml_hackathon_app_user_pool_name					= "hackathon-emergencies-app"
  cl_ir_ml_hackathon_app_user_pool_email_verification_subject   	= "Your Verification Code"
  cl_ir_ml_hackathon_app_user_pool_email_verification_message   	= "Please use the following code: {####}"
  cl_ir_ml_hackathon_app_user_pool_password_minimum_length      	= 6

  cl_ir_ml_hackathon_app_user_pool_client_name				= "cl-hackathon-emergencies-users"
  cl_ir_ml_hackathon_app_user_pool_native_client_name			= "cl-hackathon-emergencies-users-native"

  cl_ir_ml_hackathon_app_user_pool_sap_group_name			= "cl-hackathon-emergencies-users"
  cl_ir_ml_hackathon_app_user_pool_sap_group_description		= "CxLink Hackathon Emergencies Forecast Users Group"
  cl_ir_ml_hackathon_app_user_pool_sap_group_precedence			= 46
  cl_ir_ml_hackathon_app_user_pool_sap_instances_user_name		= "cl-hackathon-dummy-dev"
  cl_ir_ml_hackathon_app_user_pool_sap_instances_user_password		= "ovotha3eiCh@oo8"
  cl_ir_ml_hackathon_app_user_pool_domain_name				= "hackathon-cognito.dev.cxlink.syntax.hack"
  cl_ir_ml_hackathon_app_user_pool_domain_cert_id			= ""
  cl_ir_ml_hackathon_app_dev_domain_zone_id     		        = var.cl_ir_ml_hackathon_app_dev_domain_zone_id
  cl_ir_ml_hackathon_app_prod_domain_zone_id    			= var.cl_ir_ml_hackathon_app_prod_domain_zone_id
  cl_ir_ml_hackathon_app_user_pool_resource_server_name	        	= "cl-hackathon-emergencies-app-user-pool-resource-server"
  cl_ir_ml_hackathon_app_user_pool_sap_instances_users_email    	= "daniel.soto@syntax.com"
  cl_ir_ml_hackathon_app_custom_subdomain_name				= "hackathon-emergencies"
  cl_ir_ml_hackathon_app_custom_domain_name				= "dev.cxlink.syntax.hack"
  cl_ir_ml_hackathon_app_identity_pool_name				= "cl-hackathon-emergencies-app-identity-pool"
  cl_ir_ml_hackathon_app_identity_pool_authenticated_role_name		= "cl-hackathon-emergencies-app-identity-pool-authenticated"
  cl_ir_ml_hackathon_app_identity_pool_authenticated_role_policy_name   = "cl-hackathon-emergencies-app-identity-pool-authenticated"
  cl_ir_ml_hackathon_app_identity_pool_unauthenticated_role_name	= "cl-hackathon-emergencies-app-identity-pool-unauthenticated"
  cl_ir_ml_hackathon_app_identity_pool_unauthenticated_role_policy_name   = "cl-hackathon-emergencies-app-identity-pool-unauthenticated"  
  cl_ir_ml_hackathon_app_identity_pool_unauthenticated_identities_allowed = false
  cl_ir_ml_hackathon_app_identity_pool_classic_flow_allowed		  = true
}


module "ml_app_storage" {

  source  = "../../terraform/modules/app/storage"

  providers = {
            aws.account-585543526779-eu-west-1 = aws.account-585543526779-eu-west-1,
            aws.account-585543526779-us-east-1 = aws.account-585543526779-us-east-1,
            aws.account-742189430206-eu-west-1 = aws.account-742189430206-eu-west-1
  }

  owner                                 = var.owner
  project                               = var.project
  region                                = var.region
  vpc_id                                = var.vpc_id
  default_profile                       = var.default_profile
  stage                                 = var.stage
  prefix                                = var.prefix
  cl_ir_s3_kms_key_id                   = var.cl_ir_s3_kms_key_id

  cl_ir_ml_hackathon_app_dev_frontend_bucket_name = "amplify-cxlinkhackathon-dev-153213-deployment"
  cl_ir_ml_hackathon_app_prod_frontend_bucket_name = "amplify-cxlinkhackathon-prod-113037-deployment"
}
