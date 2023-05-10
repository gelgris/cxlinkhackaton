# Syntax Global Variables

variable "prefix" {
  description = "Syntax Infrastructure Prefix"
  default = "st"
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

variable "cl_ir_ml_hackathon_app_amplify_role_name" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify Hosting IAM Role Name"
}

variable "cl_ir_ml_hackathon_app_amplify_role_policy_name" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify Hosting IAM Role Policy Name"
}

variable "cl_ir_s3_kms_key_id" {
  type = string
  description = "CxLink Hackathon Emergencies S3 KMS Custom Key ID"
}

variable "cl_ir_ml_hackathon_app_prod_domain_zone_id" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App Master Hosted Zone ID"
}

variable "cl_ir_ml_hackathon_app_dev_domain_zone_id" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App Development Hosted Zone ID"
}

variable "cl_ir_ml_hackathon_app_master_domain_name" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App Master Environment Domain Name"
}

variable "cl_ir_ml_hackathon_app_dev_domain_name" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App Development Environment Domain Name"
}

variable "cl_ir_ml_hackathon_app_master_amplify_url" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App Master Environment "
}

variable "cl_ir_ml_hackathon_app_dev_amplify_url" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App Development Environment Canonical URL"
}

# Amplify App Values

variable "cl_ir_ml_hackathon_app_master_branch_name" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App Master Branch Name"
}

variable "cl_ir_ml_hackathon_app_master_branch_display_name" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App Master Branch Display Name"
}

variable "cl_ir_ml_hackathon_app_master_branch_description" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App Master Branch Description"
}

variable "cl_ir_ml_hackathon_app_master_branch_framework" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App Master Branch Framework"
}

variable "cl_ir_ml_hackathon_app_master_branch_stage" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App Master Branch Stage"
}

variable "cl_ir_ml_hackathon_app_development_branch_name" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App Development Branch Name"
}

variable "cl_ir_ml_hackathon_app_development_branch_display_name" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App Development Branch Display Name"
}

variable "cl_ir_ml_hackathon_app_development_branch_description" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App Development Branch Description"
}

variable "cl_ir_ml_hackathon_app_development_branch_framework" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App Development Branch Framework"
}

variable "cl_ir_ml_hackathon_app_development_branch_stage" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App Development Branch Stage"
}

variable "cl_ir_ml_hackathon_app_master_backend_name" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App Master Backend Name"
}

variable "cl_ir_ml_hackathon_app_master_artifacts" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App Master Artifacts"
}

variable "cl_ir_ml_hackathon_app_master_stack_name" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App Master Stack Name"
}

variable "cl_ir_ml_hackathon_app_development_backend_name" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App Development Backend Name"
}

variable "cl_ir_ml_hackathon_app_development_artifacts" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App Development Artifacts"
}

variable "cl_ir_ml_hackathon_app_development_stack_name" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App Development Stack Name"
}

variable "cl_ir_ml_hackathon_app_auto_branch_creation_enabled" {
  type = bool
  description = "Whether If the CxLink Hackathon Emergencies Amplify App Auto Branch Creation Feature is Enabled or Not"
}

variable "cl_ir_ml_hackathon_app_basic_auth_enabled" {
  type = bool
  description = "Whether If the CxLink Hackathon Emergencies Amplify App Basic Auth Feature is Enabled or Not"
}

variable "cl_ir_ml_hackathon_app_branch_auto_build_enabled" {
  type = bool
  description = "Whether If the CxLink Hackathon Emergencies Amplify App Auto Build Feature is Enabled or No"
}

variable "cl_ir_ml_hackathon_app_branch_auto_deletion_enabled" {
  type = bool
  description = "Whether If the CxLink Hackathon Emergencies Amplify App Auto Deletion Feature is Enabled or No"
}

variable "cl_ir_ml_hackathon_app_name" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App Name"
}

variable "cl_ir_ml_hackathon_app_repo_name" {
  type = string
  description = "CxLink Hackathon Emergencies Amplify App CodeCommit Repo"
}

/* Frontend authentication */
variable "cl_ir_fe_hackaton_role_name" {
  type = string
  description = "CxLink Hackaton Empathy Unauthenticated access role for Cognito"
}

variable "cl_ir_fe_hackaton_policy_name" {
    type = string
  description = "CxLink Hackaton Empathy Unauthenticated access policy for Cognito"
}