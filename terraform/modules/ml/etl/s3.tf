resource "aws_s3_bucket" "cl_ir_ml_hackathon_aws_forecast_raw_bucket" {
  provider = aws.account-742189430206-eu-west-1

  bucket = format("${var.cl_ir_ml_hackathon_aws_forecast_raw_bucket_name}-%s",local.environment[terraform.workspace])

  tags = local.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cl_ir_ml_hackathon_aws_forecast_raw_bucket_encryption_configuration" {
    provider = aws.account-742189430206-eu-west-1

    bucket = aws_s3_bucket.cl_ir_ml_hackathon_aws_forecast_raw_bucket.id
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.cl_ir_s3_kms_key_id
        sse_algorithm     = "aws:kms"
      }
    }
}

resource "aws_s3_bucket_ownership_controls" "cl_ir_ml_hackathon_aws_forecast_raw_bucket" {
    provider = aws.account-742189430206-eu-west-1

    bucket = aws_s3_bucket.cl_ir_ml_hackathon_aws_forecast_raw_bucket.id
    rule {
      object_ownership = "BucketOwnerPreferred"
    }
}

# Block all public access for the destination bucket.

resource "aws_s3_bucket_public_access_block" "cl_ir_ml_hackathon_aws_forecast_raw_bucket_access_block" {
    provider = aws.account-742189430206-eu-west-1

    bucket                  = aws_s3_bucket.cl_ir_ml_hackathon_aws_forecast_raw_bucket.id
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}

resource "aws_s3_bucket" "cl_ir_ml_hackathon_aws_forecast_curated_bucket" {
   provider = aws.account-742189430206-eu-west-1
  bucket = format("${var.cl_ir_ml_hackathon_aws_forecast_curated_bucket_name}-%s",local.environment[terraform.workspace])
  tags = local.tags
}


resource "aws_s3_bucket_acl" "cl_ir_ml_hackathon_aws_forecast_curated_bucket_acl" {
    provider = aws.account-742189430206-eu-west-1

    bucket = aws_s3_bucket.cl_ir_ml_hackathon_aws_forecast_curated_bucket.id
    acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cl_ir_ml_hackathon_aws_forecast_curated_bucket_encryption_configuration" {
    provider = aws.account-742189430206-eu-west-1

    bucket = aws_s3_bucket.cl_ir_ml_hackathon_aws_forecast_curated_bucket.id


    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.cl_ir_s3_kms_key_id
        sse_algorithm     = "aws:kms"
      }
    }
}

resource "aws_s3_bucket_ownership_controls" "cl_ir_ml_hackathon_aws_forecast_curated_bucket" {
    provider = aws.account-742189430206-eu-west-1

    bucket = aws_s3_bucket.cl_ir_ml_hackathon_aws_forecast_curated_bucket.id
    rule {
      object_ownership = "BucketOwnerPreferred"
    }
}

# Block all public access for the destination bucket.

resource "aws_s3_bucket_public_access_block" "cl_ir_ml_hackathon_aws_forecast_curated_bucket_access_block" {
    provider = aws.account-742189430206-eu-west-1

    bucket                  = aws_s3_bucket.cl_ir_ml_hackathon_aws_forecast_curated_bucket.id
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}

resource "aws_s3_bucket" "cl_ir_ml_hackathon_ea_glue_bucket" {
  provider = aws.account-742189430206-eu-west-1

  bucket = format("${var.cl_ir_ml_hackathon_ea_glue_bucket_name}-%s",local.environment[terraform.workspace])

  tags = local.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cl_ir_ml_hackathon_ea_glue_bucket_encryption_configuration" {
  provider = aws.account-742189430206-eu-west-1

  bucket = aws_s3_bucket.cl_ir_ml_hackathon_ea_glue_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.cl_ir_s3_kms_key_id
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "cl_ir_ml_hackathon_ea_glue_bucket" {
  provider = aws.account-742189430206-eu-west-1

  bucket = aws_s3_bucket.cl_ir_ml_hackathon_ea_glue_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Block all public access for the destination bucket.

resource "aws_s3_bucket_public_access_block" "cl_ir_ml_hackathon_ea_glue_bucket_access_block" {
  provider = aws.account-742189430206-eu-west-1

  bucket                  = aws_s3_bucket.cl_ir_ml_hackathon_ea_glue_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#resource "aws_s3_bucket_lifecycle_configuration" "cl_ir_ml_hackathon_ea_glue_bucket_lifecycle" {
#  provider = aws.account-742189430206-eu-west-1
#  bucket = aws_s3_bucket.cl_ir_ml_hackathon_ea_glue_bucket.id

  #rule {
  #  id =  format("${var.cl_ir_ml_hackathon_ea_glue_bucket_lifecycle_archive_rule_name}-%s",local.environment[terraform.workspace])

    # We dont user filter in this moment.

    #filter {
    #  tag {
    #    key   = var.cl_ir_ml_hackathon_ea_glue_bucket_lifecycle_glacier_rule_filter_key
    #    value = var.cl_ir_ml_hackathon_ea_glue_bucket_lifecycle_glacier_rule_filter_value
    #  }
    #}

  #  transition {
  #    days          = var.cl_ir_ml_hackathon_ea_glue_bucket_lifecycle_archive_rule_glacier_days
  #    storage_class = "GLACIER_IR"
  #  }
  #
  #   transition {
  #    days          =  var.cl_ir_ml_hackathon_ea_glue_bucket_lifecycle_archive_rule_deep_days
  #    storage_class = "DEEP_ARCHIVE"
  #  }
  #
  #  status = "Enabled"
  #}
 # depends_on = [aws_s3_bucket.cl_ir_ml_hackathon_ea_glue_bucket]
#}

