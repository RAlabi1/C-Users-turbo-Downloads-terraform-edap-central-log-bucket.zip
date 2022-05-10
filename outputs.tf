
output "central_logging_bucket_name" {
  description = "Name of the S3 Bucket"
  value = module.central-log-bucket.s3_bucket_id
}

output "central_logging_bucket_arn" {
  description = "Arn of S3 Bucket deployed"
  value = module.central-log-bucket.s3_bucket_arn

}

output "log_bucket_region" {
  description = "The AWS region this bucket resides in."
  value       = module.central-log-bucket.s3_bucket_region
}



