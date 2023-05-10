resource "aws_route53_record" "cl_ir_ml_hackathon_app_master_domain_record" {
  provider = aws.account-235641605167-eu-west-1 
  zone_id = var.cl_ir_ml_hackathon_app_prod_domain_zone_id
  name    = var.cl_ir_ml_hackathon_app_master_domain_name
  type    = "CNAME"
  ttl     = 5
  records = [var.cl_ir_ml_hackathon_app_master_amplify_url]
}

resource "aws_route53_record" "cl_ir_ml_hackathon_app_dev_domain_record" {
  provider = aws.account-742189430206-eu-west-1
  zone_id = var.cl_ir_ml_hackathon_app_dev_domain_zone_id
  name    = var.cl_ir_ml_hackathon_app_dev_domain_name
  type    = "CNAME"
  ttl     = 5
  records = [var.cl_ir_ml_hackathon_app_dev_amplify_url]
}

