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

variable "cl_ir_ml_hackathon_vpc_cidr" {
  type = string
  description = "CxLink ML Hackathon VPN CIDR"
}

variable "cl_ir_ml_hackathon_vpc_tenancy" {
  type = string
  description = "CxLink ML Hackathon VPC Tenancy"
  default = "default"
}

variable "cl_ir_ml_hackathon_vpc_dns_enabled" {
  type = bool
  description = "Whether If the CxLink ML Hackathon VPC DNS is enabled or not"
}

variable "cl_ir_ml_hackathon_vpc_network_metrics_enabled" {
  type = bool
  description = "Whether If the CxLink ML Hackathon VPC Networking Metrics are enabled or not"
}

variable "cl_ir_ml_hackathon_vpc_dns_hostnames_enabled" {
  type = bool
  description = "Whether If the CxLink ML Hackathon VPC DNS Hostnames are enabled or not"
}

variable "cl_ir_ml_hackathon_vpc_subet_public_a_cidr" {
  type = string
  description = "CxLink ML Hackathon VPC Public Subnet CIDR for AZ A"
}

variable "cl_ir_ml_hackathon_vpc_subet_public_b_cidr" {
  type = string
  description = "CxLink ML Hackathon VPC Public Subnet CIDR for AZ B"
}

variable "cl_ir_ml_hackathon_vpc_subet_middleware_a_cidr" {
  type = string
  description = "CxLink ML Hackathon VPC Middleware Subnet CIDR for AZ A"
}

variable "cl_ir_ml_hackathon_vpc_subet_middleware_b_cidr" {
  type = string
  description = "CxLink ML Hackathon VPC Middleware Subnet CIDR for AZ B"
}

variable "cl_ir_ml_hackathon_vpc_subet_private_a_cidr" {
  type = string
  description = "CxLink ML Hackathon VPC Private Subnet CIDR for AZ A"
}

variable "cl_ir_ml_hackathon_vpc_subet_private_b_cidr" {
  type = string
  description = "CxLink ML Hackathon VPC Private Subnet CIDR for AZ B"
}

