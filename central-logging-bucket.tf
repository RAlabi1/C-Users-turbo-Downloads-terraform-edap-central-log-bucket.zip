resource "aws_kms_key" "s3_key" {
  description             = "KMS key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

data "aws_iam_policy_document" "iam_policy_allow_logs" {
   statement {
      principals {
        type        = "Service"
        identifiers = ["logging.s3.amazonaws.com"]
      }

      actions = [
        "s3:PutObject"
      ]

      resources = [
        module.central-log-bucket.s3_bucket_arn,
        "${module.central-log-bucket.s3_bucket_arn}/*"
      ]
    }
  }

module "central-log-bucket" {
  source   = "terraform-aws-modules/s3-bucket/aws"
  bucket = "ukhsa-${var.stage}-${var.log-bucket-name}"
  acl    = "log-delivery-write"
  tags                = var.tags


  versioning = {
    enabled = true
  }

  force_destroy = true


  attach_policy                         = true
  policy                                = data.aws_iam_policy_document.iam_policy_allow_logs.json
  attach_deny_insecure_transport_policy = true



  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  # S3 Bucket Ownership Controls
  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"

  # Bucket Encryption Settings
  
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm     = var.use-sse == true ? "aws:s3" : "AES256"
      }
    }
  }



}