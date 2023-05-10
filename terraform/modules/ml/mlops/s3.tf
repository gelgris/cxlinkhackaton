resource "aws_s3_bucket" "cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket" {
  bucket = format("${var.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_name}-%s",local.environment[terraform.workspace])

  tags = local.tags
}

resource "aws_s3_bucket_acl" "cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_acl" {
  bucket = aws_s3_bucket.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_encryption_configuration" {
  bucket = aws_s3_bucket.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.cl_ir_s3_kms_key_id
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket" {
  bucket = aws_s3_bucket.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Block all public access for the destination bucket.

resource "aws_s3_bucket_public_access_block" "cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_access_block" {
  bucket                  = aws_s3_bucket.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_lifecycle" {
  bucket = aws_s3_bucket.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket.id

  rule {
    id =  format("${var.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_lifecycle_archive_rule_name}-%s",local.environment[terraform.workspace])

    # We dont user filter in this moment.

    #filter {
    #  tag {
    #    key   = var.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_lifecycle_glacier_rule_filter_key
    #    value = var.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_lifecycle_glacier_rule_filter_value
    #   }
    #}

    transition {
      days          = var.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_lifecycle_archive_rule_glacier_days
      storage_class = "GLACIER_IR"
    }
     transition {
      days          =  var.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket_lifecycle_archive_rule_deep_days
      storage_class = "DEEP_ARCHIVE"
    }
    status = "Enabled"
  }
  depends_on = [aws_s3_bucket.cl_ir_ml_hackathon_mlops_pipeline_artifacts_bucket]
}


