variable "profile" {
  description = "Account to deploy into"
  type        = string
}



variable "region" {
  description = "AWS region in which to deploy"
  type        = string
  default     = "eu-west-2"
}

variable "stage" {
  description = "Environment to deploy resources in"
  type        = string
}



### Bucket Variables ###




variable "use-sse" {
  description = "Whether to use KMS encryption on buckets"
  type        = bool
  default     = false
}






variable "tags" {
  description = "The tags to include on all resources"
  type        = map(string)
}

variable "log-bucket-name" {
  type = string
  default = "central-log-bucket"
}

data "aws_caller_identity" "current" {}

