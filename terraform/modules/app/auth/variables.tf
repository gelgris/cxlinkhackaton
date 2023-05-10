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

# Cognito Pool

variable "cl_ir_ml_hackathon_app_user_pool_resource_server_name" {
  type = string
  description = "CxLink Hackathon Emergencies Query Cognito User Pool Resource Server Name"
}

variable "cl_ir_ml_hackathon_app_user_pool_domain_cert_id" {
  type = string
  description = "CxLink Hackathon Emergencies Query Cognito Pool Domain Cert ID"
}

variable "cl_ir_ml_hackathon_app_user_pool_domain_name" {
  type = string
  description = "CxLink Hackathon Emergencies Query API Gateway Cognito Pool Domain Name"
}

variable "cl_ir_ml_hackathon_app_user_pool_name" {
  type = string
  description = "CxLink Hackathon Emergencies Query API Gateway User Pool Name"
}

variable "cl_ir_ml_hackathon_app_user_pool_email_verification_subject" {
  type = string
  description = "CxLink Hackathon Emergencies Query API Gateway Email Verification Subject"
}

variable "cl_ir_ml_hackathon_app_user_pool_email_verification_message" {
  type = string
  description = "CxLink Hackathon Emergencies Query API Gateway Email Verification Message"
}

variable "cl_ir_ml_hackathon_app_user_pool_password_minimum_length" {
  type = number
  description = "CxLink Hackathon Emergencies Query API Gateway Password Minimun Length"
}

variable "cl_ir_ml_hackathon_app_user_pool_client_name" {
  type = string
  description = "CxLink Hackathon Emergencies Query API Gateway Cognito Pool Client Name"
}

variable "cl_ir_ml_hackathon_app_user_pool_native_client_name" {
  type = string
  description = "CxLink Hackathon Emergencies Query API Gateway Cognito Pool Native Client Name"
}

# Cognito Users and Groups

variable "cl_ir_ml_hackathon_app_user_pool_sap_group_name" {
  type = string
  description = "CxLink Hackathon Emergencies Query API Gateway Cognito SAP Instance Users Group Name"
}

variable "cl_ir_ml_hackathon_app_user_pool_sap_group_description" {
  type = string
  description = "CxLink Hackathon Emergencies Query API Gateway Cognito SAP Instance Users Group Description"
}

variable "cl_ir_ml_hackathon_app_user_pool_sap_group_precedence" {
  type = number
  description = "CxLink Hackathon Emergencies Query API Gateway Cognito SAP Customers Instances Group Precendence"
}

variable "cl_ir_ml_hackathon_app_user_pool_sap_instances_user_name" {
  type = string
  description = "CxLink Hackathon Emergencies Query API Gateway Cognito Customer SAP Instance User Name"
}

variable "cl_ir_ml_hackathon_app_user_pool_sap_instances_user_password" {
  type = string
  description = "CxLink Hackathon Emergencies Query API Gateway Cognito Customer SAP Instance User Password"
}

variable "cl_ir_ml_hackathon_app_user_pool_sap_instances_users_email" {
  type = string
  description = "CxLink Hackathon Emergencies Query API Gateway Cognito Customer SAP Instance User Email"
}

variable "cl_ir_ml_hackathon_app_dev_domain_zone_id" {
  type = string
  description = "CxLink Hackathon Emergencies App Route53 Development Hosted Zone ID"
}

variable "cl_ir_ml_hackathon_app_prod_domain_zone_id" {
  type = string
  description = "CxLink Hackathon Emergencies App Route53 Production Hosted Zone ID"
}

variable "cl_ir_ml_hackathon_app_custom_subdomain_name" {
  type = string
  description = "CxLink Hackathon Emergencies App Custom Subdomain Name"
}

variable "cl_ir_ml_hackathon_app_custom_domain_name" {
  type = string
  description = "CxLink Hackathon Emergencies App Custom Domain Name"
}

variable "cl_ir_ml_hackathon_app_identity_pool_name" {
  type = string
  description = "CxLink Hackathon Emergencies App Cognito Identity Pool Name"
}

variable "cl_ir_ml_hackathon_app_identity_pool_unauthenticated_identities_allowed" {
  type = bool
  description = "Whether If the CxLink Hackathon Emergencies App Cognito Identity Pool Unauthenticated Identities are allowed or not"
}

variable "cl_ir_ml_hackathon_app_identity_pool_classic_flow_allowed" {
  type = bool
  description = "Whether If the CxLink Hackathon Emergencies App Cognito Identity Pool Classic (basic) Authentication Flow is Enabled or not"
}

variable "cl_ir_ml_hackathon_app_identity_pool_authenticated_role_name" {
  type = string
  description = "CxLink Hackathon Emergencies App Cognito Identity Pool Authenticated IAM Role Name"
}

variable "cl_ir_ml_hackathon_app_identity_pool_authenticated_role_policy_name" {
  type = string
  description = "CxLink Hackathon Emergencies App Cognito Identity Pool Authenticated IAM Role Policy Name"
}

variable "cl_ir_ml_hackathon_app_identity_pool_unauthenticated_role_name" {
  type = string
  description = "CxLink Hackathon Emergencies App Cognito Identity Pool Unauthenticated IAM Role Name"
}

variable "cl_ir_ml_hackathon_app_identity_pool_unauthenticated_role_policy_name" {
  type = string
  description = "CxLink Hackathon Emergencies App Cognito Identity Pool Unauthenticated IAM Role Policy Name"
}
