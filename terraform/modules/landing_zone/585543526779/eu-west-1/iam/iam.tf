resource "aws_iam_user" "cl_ir_ml_hackathon_empathy_aws_iam_read_only_user" {
  provider = aws.account-585543526779-eu-west-1

  name = format("${var.cl_ir_ml_hackathon_empathy_aws_iam_read_only_user_name}-%s",local.environment[terraform.workspace])
  path = "/"

  tags = local.tags
}

#resource "aws_iam_policy" "cl_ir_ml_hackathon_empathy_aws_iam_read_only_user_policy" {
#  provider = aws.account-585543526779-eu-west-1
#
#  name = format("${var.cl_ir_ml_hackathon_empathy_aws_iam_read_only_user_policy_name}-%s",local.environment[terraform.workspace])
#  description = "Policiy for the CxLink AWS Auditor"
#  path = "/"
#  tags = local.tags
#  policy = jsonencode({
#    "Version" : "2012-10-17",
#    "Statement" : [
#     ]
#  })
#}


#resource "aws_iam_user_policy_attachment" "cl_ir_ml_hackathon_empathy_aws_iam_read_only_user_policy_attachment" {
#  provider = aws.account-585543526779-eu-west-1
#
#  user       = aws_iam_user.cl_ir_ml_hackathon_empathy_aws_iam_read_only_user.name
#  policy_arn = aws_iam_policy.cl_ir_ml_hackathon_empathy_aws_iam_read_only_user_policy.arn
#}

resource "aws_iam_user_policy_attachment" "cl_ir_ml_hackathon_empathy_aws_iam_read_only_user_ReadOnlyAccess_policy_attachment" {
  provider = aws.account-585543526779-eu-west-1

  user       = aws_iam_user.cl_ir_ml_hackathon_empathy_aws_iam_read_only_user.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
