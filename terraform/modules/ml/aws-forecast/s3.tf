resource "aws_s3_bucket" "cl_ir_ml_hackathon_aws_forecast_raw_bucket" {
  for_each = local.cl_ir_ml_hackathon_aws_forecast_customers
    bucket = format("${each.value.raw_bucket_name}-%s-%s",try(each.value.customer_id, ""),local.environment[terraform.workspace])

  tags = merge(local.tags, {"CustomerId":"${try(each.value.customer_id, "")}"})
}

resource "aws_s3_bucket_cors_configuration" "cl_ir_ml_hackathon_aws_forecast_raw_bucket_cors" {
  for_each = aws_s3_bucket.cl_ir_ml_hackathon_aws_forecast_raw_bucket
    bucket = each.value.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "HEAD", "DELETE", "GET"]
    allowed_origins = ["http://localhost:8080"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}


resource "aws_s3_bucket_acl" "cl_ir_ml_hackathon_aws_forecast_raw_bucket_acl" {
  for_each = aws_s3_bucket.cl_ir_ml_hackathon_aws_forecast_raw_bucket
    bucket = each.value.id
    acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cl_ir_ml_hackathon_aws_forecast_raw_bucket_encryption_configuration" {
  for_each = aws_s3_bucket.cl_ir_ml_hackathon_aws_forecast_raw_bucket
    bucket = each.value.id
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.cl_ir_s3_kms_key_id
        sse_algorithm     = "aws:kms"
      }
    }
}

resource "aws_s3_bucket_ownership_controls" "cl_ir_ml_hackathon_aws_forecast_raw_bucket" {
  for_each = aws_s3_bucket.cl_ir_ml_hackathon_aws_forecast_raw_bucket
    bucket = each.value.id
    rule {
      object_ownership = "BucketOwnerPreferred"
    }
}

# Block all public access for the destination bucket.

resource "aws_s3_bucket_public_access_block" "cl_ir_ml_hackathon_aws_forecast_raw_bucket_access_block" {
  for_each = aws_s3_bucket.cl_ir_ml_hackathon_aws_forecast_raw_bucket

    bucket                  = each.value.id
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "cl_ir_ml_hackathon_aws_forecast_raw_bucket_lifecycle" {
  for_each = aws_s3_bucket.cl_ir_ml_hackathon_aws_forecast_raw_bucket
    bucket = each.value.id

    rule {
      id =  format("${var.cl_ir_ml_hackathon_aws_forecast_raw_bucket_lifecycle_archive_rule_name}-%s",local.environment[terraform.workspace])

      # We dont user filter in this moment.

      #filter {
      #  tag {
      #    key   = var.cl_ir_ml_hackathon_aws_forecast_raw_bucket_lifecycle_glacier_rule_filter_key
      #    value = var.cl_ir_ml_hackathon_aws_forecast_raw_bucket_lifecycle_glacier_rule_filter_value
      #  }
      #}

      transition {
        days          = var.cl_ir_ml_hackathon_aws_forecast_raw_bucket_lifecycle_archive_rule_glacier_days
        storage_class = "GLACIER_IR"
      }

       transition {
        days          =  var.cl_ir_ml_hackathon_aws_forecast_raw_bucket_lifecycle_archive_rule_deep_days
        storage_class = "DEEP_ARCHIVE"
      }

      status = "Enabled"
    }
    depends_on = [aws_s3_bucket.cl_ir_ml_hackathon_aws_forecast_raw_bucket]
}

resource "aws_s3_bucket_notification" "cl_ir_ml_hackathon_aws_forecast_raw_bucket_notification" {

  # Because of the way that AWS CloudFormation handles dependency ordering,
  # Amazon S3 event notifications are defined as an attribute of the S3 bucket. These notifications are established when the S3 bucket resource is created.
  # Ref: https://aws.amazon.com/premiumsupport/knowledge-center/unable-validate-destination-s3/


  for_each = aws_s3_bucket.cl_ir_ml_hackathon_aws_forecast_raw_bucket
    bucket = each.value.id

    lambda_function {
      lambda_function_arn = format("arn:aws:lambda:${var.region}:${data.aws_caller_identity.current.account_id}:function:%s-%s",var.cl_ir_hackathon_empathy_extract_lambda_function_name,local.environment[terraform.workspace])
      #events              = ["s3:ObjectCreated:*"] # https://docs.aws.amazon.com/AmazonS3/latest/
       						 # userguide/notification-how-to-event-types-and-destinations.html#supported-notification-event-types
      events              = ["s3:ObjectCreated:Put"]
      filter_prefix       = "${data.aws_caller_identity.current.account_id}/${var.region}/${var.cl_ir_ml_hackathon_aws_forecast_raw_bucket_notification_filter_prefix}"
      filter_suffix       = var.cl_ir_ml_hackathon_aws_forecast_raw_bucket_notification_filter_suffix
    }

    lambda_function {
      lambda_function_arn = format("arn:aws:lambda:${var.region}:${data.aws_caller_identity.current.account_id}:function:%s-%s",var.cl_ir_hackathon_empathy_filter_lambda_function_name,local.environment[terraform.workspace])
      #events              = ["s3:ObjectCreated:*"] # https://docs.aws.amazon.com/AmazonS3/latest/
       						 # userguide/notification-how-to-event-types-and-destinations.html#supported-notification-event-types
      events              = ["s3:ObjectCreated:Put"]
      filter_prefix       = "${data.aws_caller_identity.current.account_id}/${var.region}/${var.cl_ir_ml_hackathon_filter_lambda_aws_forecast_raw_bucket_notification_filter_prefix}"
      filter_suffix       = var.cl_ir_ml_hackathon_filter_lambda_aws_forecast_raw_bucket_notification_filter_suffix
    }

    lambda_function {
      lambda_function_arn = format("arn:aws:lambda:${var.region}:${data.aws_caller_identity.current.account_id}:function:%s-%s",var.cl_ir_hackathon_empathy_audio_lambda_function_name,local.environment[terraform.workspace])
      #events              = ["s3:ObjectCreated:*"] # https://docs.aws.amazon.com/AmazonS3/latest/
       						 # userguide/notification-how-to-event-types-and-destinations.html#supported-notification-event-types
      events              = ["s3:ObjectCreated:Put"]
      filter_prefix       = "${data.aws_caller_identity.current.account_id}/${var.region}/${var.cl_ir_ml_hackathon_audio_lambda_aws_forecast_raw_bucket_notification_filter_prefix}"
      #filter_suffix       = var.cl_ir_ml_hackathon_audio_lambda_aws_forecast_raw_bucket_notification_filter_suffix
    }

    lambda_function {
      lambda_function_arn = format("arn:aws:lambda:${var.region}:${data.aws_caller_identity.current.account_id}:function:%s-%s",var.cl_ir_hackathon_empathy_text_lambda_function_name,local.environment[terraform.workspace])
      #events              = ["s3:ObjectCreated:*"] # https://docs.aws.amazon.com/AmazonS3/latest/
       						 # userguide/notification-how-to-event-types-and-destinations.html#supported-notification-event-types
      events              = ["s3:ObjectCreated:Put"]
      filter_prefix       = "${data.aws_caller_identity.current.account_id}/${var.region}/${var.cl_ir_ml_hackathon_text_lambda_aws_forecast_raw_bucket_notification_filter_prefix}"
      filter_suffix       = var.cl_ir_ml_hackathon_text_lambda_aws_forecast_raw_bucket_notification_filter_suffix
    }
}

resource "aws_s3_bucket" "cl_ir_ml_hackathon_aws_forecast_curated_bucket" {
  for_each = local.cl_ir_ml_hackathon_aws_forecast_customers
    bucket = format("${each.value.curated_bucket_name}-%s-%s",try(each.value.customer_id, ""),local.environment[terraform.workspace])

  tags = merge(local.tags, {"CustomerId":"${try(each.value.customer_id, "")}"})
}


resource "aws_s3_bucket_cors_configuration" "cl_ir_ml_hackathon_aws_forecast_curated_bucket_cors" {
  for_each = aws_s3_bucket.cl_ir_ml_hackathon_aws_forecast_curated_bucket
    bucket = each.value.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "HEAD", "DELETE", "GET"]
    allowed_origins = ["http://localhost:8080"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_acl" "cl_ir_ml_hackathon_aws_forecast_curated_bucket_acl" {
  for_each = aws_s3_bucket.cl_ir_ml_hackathon_aws_forecast_curated_bucket
    bucket = each.value.id
    acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cl_ir_ml_hackathon_aws_forecast_curated_bucket_encryption_configuration" {
  for_each = aws_s3_bucket.cl_ir_ml_hackathon_aws_forecast_curated_bucket
    bucket = each.value.id


    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.cl_ir_s3_kms_key_id
        sse_algorithm     = "aws:kms"
      }
    }
}

resource "aws_s3_bucket_ownership_controls" "cl_ir_ml_hackathon_aws_forecast_curated_bucket" {
  for_each = aws_s3_bucket.cl_ir_ml_hackathon_aws_forecast_curated_bucket
    bucket = each.value.id
    rule {
      object_ownership = "BucketOwnerPreferred"
    }
}

# Block all public access for the destination bucket.

resource "aws_s3_bucket_public_access_block" "cl_ir_ml_hackathon_aws_forecast_curated_bucket_access_block" {
  for_each = aws_s3_bucket.cl_ir_ml_hackathon_aws_forecast_curated_bucket
    bucket                  = each.value.id
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "cl_ir_ml_hackathon_aws_forecast_curated_bucket_lifecycle" {
  for_each = aws_s3_bucket.cl_ir_ml_hackathon_aws_forecast_curated_bucket
    bucket = each.value.id

    rule {
      id =  format("${var.cl_ir_ml_hackathon_aws_forecast_curated_bucket_lifecycle_archive_rule_name}-%s",local.environment[terraform.workspace])

      # We dont user filter in this moment.

      #filter {
      #  tag {
      #    key   = var.cl_ir_ml_hackathon_aws_forecast_curated_bucket_lifecycle_glacier_rule_filter_key
      #    value = var.cl_ir_ml_hackathon_aws_forecast_curated_bucket_lifecycle_glacier_rule_filter_value
      #  }
      #}

      transition {
        days          = var.cl_ir_ml_hackathon_aws_forecast_curated_bucket_lifecycle_archive_rule_glacier_days
        storage_class = "GLACIER_IR"
      }

       transition {
        days          =  var.cl_ir_ml_hackathon_aws_forecast_curated_bucket_lifecycle_archive_rule_deep_days
        storage_class = "DEEP_ARCHIVE"
      }

      status = "Enabled"
    }
    depends_on = [aws_s3_bucket.cl_ir_ml_hackathon_aws_forecast_curated_bucket]
}
