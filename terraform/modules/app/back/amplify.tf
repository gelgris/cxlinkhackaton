# Hosting Environments

resource "aws_amplify_branch" "cl_ir_ml_hackathon_app_master" {
  app_id       = aws_amplify_app.cl_ir_ml_hackathon_app.id
  branch_name  = var.cl_ir_ml_hackathon_app_master_branch_name
  display_name = var.cl_ir_ml_hackathon_app_master_branch_display_name
  description  = var.cl_ir_ml_hackathon_app_master_branch_description
  framework    = var.cl_ir_ml_hackathon_app_master_branch_framework
  stage        = var.cl_ir_ml_hackathon_app_master_branch_stage
  backend_environment_arn= aws_amplify_backend_environment.cl_ir_ml_hackathon_app_master_backend.arn

  #environment_variables = {
  #  REACT_APP_API_SERVER = "https://api.example.com"
  #}
  tags = local.tags
}

resource "aws_amplify_branch" "cl_ir_ml_hackathon_app_development" {
  app_id       = aws_amplify_app.cl_ir_ml_hackathon_app.id
  branch_name  = var.cl_ir_ml_hackathon_app_development_branch_name
  display_name = var.cl_ir_ml_hackathon_app_development_branch_display_name
  description  = var.cl_ir_ml_hackathon_app_development_branch_description
  framework = var.cl_ir_ml_hackathon_app_development_branch_framework
  stage     = var.cl_ir_ml_hackathon_app_development_branch_stage
  backend_environment_arn= aws_amplify_backend_environment.cl_ir_ml_hackathon_app_development_backend.arn

  #environment_variables = {
  #  REACT_APP_API_SERVER = "https://api.example.com"
  #}
  tags = local.tags
}

# Backend Environments

resource "aws_amplify_backend_environment" "cl_ir_ml_hackathon_app_master_backend" {
  app_id           = aws_amplify_app.cl_ir_ml_hackathon_app.id
  environment_name = var.cl_ir_ml_hackathon_app_master_backend_name

  deployment_artifacts = format("${var.cl_ir_ml_hackathon_app_master_artifacts}-%s",local.environment[terraform.workspace])
  stack_name           = format("${var.cl_ir_ml_hackathon_app_master_stack_name}-%s",local.environment[terraform.workspace])
}

resource "aws_amplify_backend_environment" "cl_ir_ml_hackathon_app_development_backend" {
  app_id           = aws_amplify_app.cl_ir_ml_hackathon_app.id
  environment_name = var.cl_ir_ml_hackathon_app_development_backend_name

  deployment_artifacts = format("${var.cl_ir_ml_hackathon_app_development_artifacts}-%s",local.environment[terraform.workspace])
  stack_name           = format("${var.cl_ir_ml_hackathon_app_master_stack_name}-%s",local.environment[terraform.workspace])
}


#resource "aws_amplify_domain_association" "cl_ir_ml_hackathon_app_domain" {
#  app_id      = aws_amplify_app.cl_ir_ml_hackathon_app.id
#  domain_name = "hackathon.cxlink.syntax.hack"
#
#  sub_domain {
#    branch_name = aws_amplify_branch.cl_ir_ml_hackathon_app_master.branch_name
#    prefix      = ""
#  }
#
#  sub_domain {
#    branch_name = aws_amplify_branch.cl_ir_ml_hackathon_app_development.branch_name
#    prefix      = "dev"
#  }
#}

resource "aws_amplify_app" "cl_ir_ml_hackathon_app" {
  name = var.cl_ir_ml_hackathon_app_name
  enable_auto_branch_creation = var.cl_ir_ml_hackathon_app_auto_branch_creation_enabled
  enable_basic_auth  = var.cl_ir_ml_hackathon_app_basic_auth_enabled
  enable_branch_auto_build = var.cl_ir_ml_hackathon_app_branch_auto_build_enabled
  enable_branch_auto_deletion = var.cl_ir_ml_hackathon_app_branch_auto_deletion_enabled

  environment_variables = {
    _LIVE_UPDATES = "[{\"name\":\"Amplify CLI\",\"pkg\":\"@aws-amplify/cli\",\"type\":\"npm\",\"version\":\"latest\"}]",
     AMPLIFY_USERPOOL_ID = "eu-west-1_3ey62n01r"
     AMPLIFY_WEBCLIENT_ID = "6ori1qd2vu342v8oh8b6qt1qmk"
     AMPLIFY_NATIVECLIENT_ID = "5qop1tb8s7nbapjd0dm32qa20a"
     AMPLIFY_IDENTITYPOOL_ID= "eu-west-1:ca7b7f9d-558c-4523-beea-38ae6aa3c42d"
  }

  #custom_rule {
  #              source = "/<*>"
  #              target = "/index.html"
  #              status = "404-200"
  #}

  iam_service_role_arn = aws_iam_role.cl_ir_ml_hackathon_app_amplify_role.arn
  repository = format("https://git-codecommit.${var.region}.amazonaws.com/v1/repos/${var.cl_ir_ml_hackathon_app_repo_name}-%s",local.environment[terraform.workspace])
  tags = local.tags

  build_spec = <<-EOT
    version: 1
    frontend:
      phases:
        # IMPORTANT - Please verify your build commands
        build:
          commands: []
      artifacts:
        # IMPORTANT - Please verify your build output directory
        baseDirectory: /
        files:
          - '**/*'
      cache:
        paths: []
  EOT
}

