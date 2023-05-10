resource "aws_security_group" "cl_ir_ml_hackathon_mlops_codebuild_security_group" {
  name = format("${var.cl_ir_ml_hackathon_mlops_codebuild_security_group_name}-%s",local.environment[terraform.workspace])

  description = "CxLink AWS Forecast CodeBuild Security Group"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}

