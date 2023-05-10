resource "aws_cognito_user_pool" "cl_ir_ml_hackathon_app_user_pool" {
  provider = aws.account-585543526779-eu-west-1
  name = format("${var.cl_ir_ml_hackathon_app_user_pool_name}-%s",local.environment[terraform.workspace])

  email_verification_subject = var.cl_ir_ml_hackathon_app_user_pool_email_verification_subject
  email_verification_message = var.cl_ir_ml_hackathon_app_user_pool_email_verification_message
  alias_attributes           = ["email"]
  auto_verified_attributes   = ["email"]

  password_policy {
    minimum_length    = var.cl_ir_ml_hackathon_app_user_pool_password_minimum_length
    temporary_password_validity_days = 7
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  username_configuration {
    case_sensitive = false
  }

  # Schema for the user attributes

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
    required                 = true

    string_attribute_constraints {
      min_length = 7
      max_length = 256
    }
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "name"
    required                 = true

    string_attribute_constraints {
      min_length = 3
      max_length = 256
    }
  }
}

resource "aws_cognito_user_pool_client" "cl_ir_ml_hackathon_app_user_pool_client" {
  provider = aws.account-585543526779-eu-west-1
  name                         = format("${var.cl_ir_ml_hackathon_app_user_pool_client_name}-%s",local.environment[terraform.workspace])

  explicit_auth_flows          = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
  user_pool_id = aws_cognito_user_pool.cl_ir_ml_hackathon_app_user_pool.id
  generate_secret = false

  enable_token_revocation = true
  refresh_token_validity  = 1
  id_token_validity       = 1
  access_token_validity   = 1
  auth_session_validity   = 3

  token_validity_units {
    access_token	= "days"
    id_token		= "days"
    refresh_token	= "days"
  }

  callback_urls = ["https://localhost"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows = ["code", "implicit"]
  allowed_oauth_scopes = ["aws.cognito.signin.user.admin"]
  supported_identity_providers  = ["COGNITO"]

 #allowed_oauth_flows
 #allowed_oauth_scopes 

}

resource "aws_cognito_user_pool_client" "cl_ir_ml_hackathon_app_user_pool_native_client" {
  provider = aws.account-585543526779-eu-west-1
  name                         = format("${var.cl_ir_ml_hackathon_app_user_pool_native_client_name}-%s",local.environment[terraform.workspace])

  explicit_auth_flows          = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
  user_pool_id = aws_cognito_user_pool.cl_ir_ml_hackathon_app_user_pool.id
  generate_secret = false

  enable_token_revocation = true
  refresh_token_validity  = 1
  id_token_validity       = 1
  access_token_validity   = 1
  auth_session_validity   = 3

  token_validity_units {
    access_token	= "days"
    id_token		= "days"
    refresh_token	= "days"
  }

  callback_urls = ["https://localhost"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows = ["code", "implicit"]
  allowed_oauth_scopes = ["aws.cognito.signin.user.admin"]
  supported_identity_providers  = ["COGNITO"]

 #allowed_oauth_flows
 #allowed_oauth_scopes 

}

resource "aws_cognito_user_group" "cl_ir_ml_hackathon_app_user_pool_sap_group" {
  provider = aws.account-585543526779-eu-west-1
  name         = format("${var.cl_ir_ml_hackathon_app_user_pool_sap_group_name}-%s",local.environment[terraform.workspace])
  description  = var.cl_ir_ml_hackathon_app_user_pool_sap_group_description
  user_pool_id = aws_cognito_user_pool.cl_ir_ml_hackathon_app_user_pool.id
  precedence   = var.cl_ir_ml_hackathon_app_user_pool_sap_group_precedence
  #role_arn     = aws_iam_role..arn
}

# TODO: Iterate over for yamls

resource "aws_cognito_user" "cl_ir_ml_hackathon_app_user_pool_sap_instances_users" {
  provider = aws.account-585543526779-eu-west-1
  user_pool_id = aws_cognito_user_pool.cl_ir_ml_hackathon_app_user_pool.id
  username     = var.cl_ir_ml_hackathon_app_user_pool_sap_instances_user_name
  password     = var.cl_ir_ml_hackathon_app_user_pool_sap_instances_user_password

  attributes = {
    email          = var.cl_ir_ml_hackathon_app_user_pool_sap_instances_users_email
    email_verified = true
  }
}

resource "aws_cognito_user_in_group" "cl_ir_ml_hackathon_app_user_pool_sap_instances_users_in_group" {
  provider = aws.account-585543526779-eu-west-1
  user_pool_id = aws_cognito_user_pool.cl_ir_ml_hackathon_app_user_pool.id
  group_name   = aws_cognito_user_group.cl_ir_ml_hackathon_app_user_pool_sap_group.name
  username     = aws_cognito_user.cl_ir_ml_hackathon_app_user_pool_sap_instances_users.username
}

#resource "aws_cognito_user_pool_domain" "cl_ir_ml_hackathon_app_user_pool_domain" {
#  provider = aws.account-585543526779-eu-west-1
#  domain          = var.cl_ir_ml_hackathon_app_user_pool_domain_name
#  certificate_arn = "arn:aws:acm:us-east-1:${data.aws_caller_identity.current.account_id}:certificate/${var.cl_ir_ml_hackathon_app_user_pool_domain_cert_id}"
#  user_pool_id    = aws_cognito_user_pool.cl_ir_ml_hackathon_app_user_pool.id
#}

resource "aws_cognito_resource_server" "cl_ir_ml_hackathon_app_user_pool_resource_server" {
  provider = aws.account-585543526779-eu-west-1
  identifier =  format("%s-${var.cl_ir_ml_hackathon_app_custom_domain_name}",local.environment[terraform.workspace])
  name       = var.cl_ir_ml_hackathon_app_user_pool_resource_server_name

  scope {
    scope_name        = "sample-scope"
    scope_description = "a Sample Scope Description"
  }

  user_pool_id = aws_cognito_user_pool.cl_ir_ml_hackathon_app_user_pool.id
}

resource "aws_cognito_identity_pool" "cl_ir_ml_hackathon_app_identity_pool" {
  provider = aws.account-585543526779-eu-west-1
  identity_pool_name               = format("${var.cl_ir_ml_hackathon_app_identity_pool_name}-%s",local.environment[terraform.workspace])
  allow_unauthenticated_identities = var.cl_ir_ml_hackathon_app_identity_pool_unauthenticated_identities_allowed
  allow_classic_flow               = var.cl_ir_ml_hackathon_app_identity_pool_classic_flow_allowed

  cognito_identity_providers {
    client_id               = aws_cognito_user_pool_client.cl_ir_ml_hackathon_app_user_pool_client.id
    provider_name           = "cognito-idp.${var.region}.amazonaws.com/${aws_cognito_user_pool.cl_ir_ml_hackathon_app_user_pool.id}"
    server_side_token_check = false
  }
}

#resource "aws_cognito_user_pool_ui_customization" "cl_ir_ml_hackathon_app_user_pool_ui" {
#  provider = aws.account-585543526779-eu-west-1
#  client_id = aws_cognito_user_pool_client.cl_ir_ml_hackathon_app_user_pool_client.id


#  css        = ".label-customizable {font-weight: 400;}"
#  image_file = filebase64("logo.png")

  # Refer to the aws_cognito_user_pool_domain resource's
  # user_pool_id attribute to ensure it is in an 'Active' state
  #user_pool_id = aws_cognito_user_pool_domain.cl_ir_ml_hackathon_app_user_pool_domain.user_pool_id
#}


#resource "aws_cognito_risk_configuration" "cl_ir_ml_hackathon_app_user_pool_risk_config" {
#  user_pool_id = aws_cognito_user_pool.cl_ir_ml_hackathon_app_user_pool.id
#  client_id  = aws_cognito_user_pool_client.cl_ir_ml_hackathon_app_user_pool_client.id
#
#  risk_exception_configuration {
#    blocked_ip_range_list = var.cl_ir_ml_hackathon_app_user_pool_black_list
#  }
#
#  account_takeover_risk_configuration {
#    notify_configuration {
#      block_email
#      mfa_email
#      no_action_email
#      from
#      reply_to
#      source_arn 
#    }
#    notify email type {
#      html_body
#      subject
#      text_body
#    }
#
#    actions {
#      high_action 
#      low_action 
#      medium_action
#    }
#  }
#
#  compromised_credentials_risk_configuration {
#  }
#
#  risk_exception_configuration {
#  }
#}


data "aws_iam_policy_document" "cl_ir_ml_hackathon_app_identity_pool_authenticated_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = ["cognito-identity.amazonaws.com"]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "cognito-identity.amazonaws.com:aud"
      values   = [aws_cognito_identity_pool.cl_ir_ml_hackathon_app_identity_pool.id]
    }

    condition {
      test     = "ForAnyValue:StringLike"
      variable = "cognito-identity.amazonaws.com:amr"
      values   = ["authenticated"]
    }
  }
}

data "aws_iam_policy_document" "cl_ir_ml_hackathon_app_identity_pool_authenticated_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "mobileanalytics:PutEvents",
      "cognito-sync:*",
      "cognito-identity:*",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role" "cl_ir_ml_hackathon_app_identity_pool_authenticated_role" {
  name               = format("${var.cl_ir_ml_hackathon_app_identity_pool_authenticated_role_name}-%s",local.environment[terraform.workspace])
  assume_role_policy = data.aws_iam_policy_document.cl_ir_ml_hackathon_app_identity_pool_authenticated_assume_role_policy.json
}

resource "aws_iam_role_policy" "cl_ir_ml_hackathon_app_identity_pool_authenticated_role_policy" {
  name   = format("${var.cl_ir_ml_hackathon_app_identity_pool_authenticated_role_policy_name}-%s",local.environment[terraform.workspace])
  role   = aws_iam_role.cl_ir_ml_hackathon_app_identity_pool_authenticated_role.id
  policy = data.aws_iam_policy_document.cl_ir_ml_hackathon_app_identity_pool_authenticated_role_policy.json
}

data "aws_iam_policy_document" "cl_ir_ml_hackathon_app_identity_pool_unauthenticated_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = ["cognito-identity.amazonaws.com"]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "cognito-identity.amazonaws.com:aud"
      values   = [aws_cognito_identity_pool.cl_ir_ml_hackathon_app_identity_pool.id]
    }

    condition {
      test     = "ForAnyValue:StringLike"
      variable = "cognito-identity.amazonaws.com:amr"
      values   = ["unauthenticated"]
    }
  }
}

data "aws_iam_policy_document" "cl_ir_ml_hackathon_app_identity_pool_unauthenticated_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "transcribe:StartStreamTranscriptionWebSocket",
      "cognito-sync:*",
      "comprehend:DetectDominantLanguage",
      "translate:TranslateText",
      "s3:*",
      "kms:*"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role" "cl_ir_ml_hackathon_app_identity_pool_unauthenticated_role" {
  name               = format("${var.cl_ir_ml_hackathon_app_identity_pool_unauthenticated_role_name}-%s",local.environment[terraform.workspace])
  assume_role_policy = data.aws_iam_policy_document.cl_ir_ml_hackathon_app_identity_pool_unauthenticated_assume_role_policy.json
}

resource "aws_iam_role_policy" "cl_ir_ml_hackathon_app_identity_pool_unauthenticated_role_policy" {
  name   = format("${var.cl_ir_ml_hackathon_app_identity_pool_unauthenticated_role_policy_name}-%s",local.environment[terraform.workspace])
  role   = aws_iam_role.cl_ir_ml_hackathon_app_identity_pool_unauthenticated_role.id
  policy = data.aws_iam_policy_document.cl_ir_ml_hackathon_app_identity_pool_unauthenticated_role_policy.json
}

resource "aws_cognito_identity_pool_roles_attachment" "cl_ir_ml_hackathon_app_identity_pool_authenticated_role_attachment" {
  identity_pool_id = aws_cognito_identity_pool.cl_ir_ml_hackathon_app_identity_pool.id

  #role_mapping {
  #  identity_provider         = "graph.facebook.com"
  #  ambiguous_role_resolution = "AuthenticatedRole"
  #  type                      = "Rules"
  #
  #  mapping_rule {
  #    claim      = "isAdmin"
  #    match_type = "Equals"
  #    role_arn   = aws_iam_role.cl_ir_ml_hackathon_app_identity_pool_authenticated_role.arn
  #    value      = "paid"
  #  }
  #}

  roles = {
    "authenticated" = aws_iam_role.cl_ir_ml_hackathon_app_identity_pool_authenticated_role.arn
    "unauthenticated" = aws_iam_role.cl_ir_ml_hackathon_app_identity_pool_unauthenticated_role.arn
  }
}
