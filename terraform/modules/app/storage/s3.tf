# TODO: Migrate this to Spain Region
# http://cl-ir-ml-hackathon-app-front-dev.s3-website-eu-west-1.amazonaws.com

resource "aws_s3_bucket" "cl_ir_ml_hackathon_app_dev_frontend_bucket" {
  provider = aws.account-585543526779-eu-west-1

  #bucket = format("${var.cl_ir_ml_hackathon_app_dev_frontend_bucket_name}-%s",local.environment[terraform.workspace])
  bucket = var.cl_ir_ml_hackathon_app_dev_frontend_bucket_name

  tags = local.tags
}

resource "aws_s3_bucket_acl" "cl_ir_ml_hackathon_app_dev_frontend_bucket_acl" {
  provider = aws.account-585543526779-eu-west-1

  bucket = aws_s3_bucket.cl_ir_ml_hackathon_app_dev_frontend_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cl_ir_ml_hackathon_app_dev_frontend_bucket_encryption_configuration" {
  provider = aws.account-585543526779-eu-west-1

  bucket = aws_s3_bucket.cl_ir_ml_hackathon_app_dev_frontend_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.cl_ir_s3_kms_key_id
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "cl_ir_ml_hackathon_app_dev_frontend_bucket" {
  provider = aws.account-585543526779-eu-west-1

  bucket = aws_s3_bucket.cl_ir_ml_hackathon_app_dev_frontend_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Block all public access for the destination bucket.

resource "aws_s3_bucket_public_access_block" "cl_ir_ml_hackathon_app_dev_frontend_bucket_access_block" {
  provider = aws.account-585543526779-eu-west-1

  bucket                  = aws_s3_bucket.cl_ir_ml_hackathon_app_dev_frontend_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Hosting Mode Config

resource "aws_s3_bucket_website_configuration" "cl_ir_ml_hackathon_app_dev_frontend_bucket_webconfig" {
  provider = aws.account-585543526779-eu-west-1

  bucket = aws_s3_bucket.cl_ir_ml_hackathon_app_dev_frontend_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  #routing_rule {
  #  condition {
  #    key_prefix_equals = "docs/"
  #  }
  #  redirect {
  #    replace_key_prefix_with = "documents/"
  #  }
  #}
}

resource "aws_s3_bucket" "cl_ir_ml_hackathon_app_prod_frontend_bucket" {
  provider = aws.account-585543526779-eu-west-1

  #bucket = format("${var.cl_ir_ml_hackathon_app_prod_frontend_bucket_name}-%s",local.environment[terraform.workspace])
  bucket = var.cl_ir_ml_hackathon_app_prod_frontend_bucket_name

  tags = local.tags
}

resource "aws_s3_bucket_acl" "cl_ir_ml_hackathon_app_prod_frontend_bucket_acl" {
  provider = aws.account-585543526779-eu-west-1

  bucket = aws_s3_bucket.cl_ir_ml_hackathon_app_prod_frontend_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cl_ir_ml_hackathon_app_prod_frontend_bucket_encryption_configuration" {
  provider = aws.account-585543526779-eu-west-1

  bucket = aws_s3_bucket.cl_ir_ml_hackathon_app_prod_frontend_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.cl_ir_s3_kms_key_id
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "cl_ir_ml_hackathon_app_prod_frontend_bucket" {
  provider = aws.account-585543526779-eu-west-1

  bucket = aws_s3_bucket.cl_ir_ml_hackathon_app_prod_frontend_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Block all public access for the destination bucket.

resource "aws_s3_bucket_public_access_block" "cl_ir_ml_hackathon_app_prod_frontend_bucket_access_block" {
  provider = aws.account-585543526779-eu-west-1

  bucket                  = aws_s3_bucket.cl_ir_ml_hackathon_app_prod_frontend_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Hosting Mode Config

resource "aws_s3_bucket_website_configuration" "cl_ir_ml_hackathon_app_prod_frontend_bucket_webconfig" {
  provider = aws.account-585543526779-eu-west-1

  bucket = aws_s3_bucket.cl_ir_ml_hackathon_app_prod_frontend_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  #routing_rule {
  #  condition {
  #    key_prefix_equals = "docs/"
  #  }
  #  redirect {
  #    replace_key_prefix_with = "documents/"
  #  }
  #}
}
