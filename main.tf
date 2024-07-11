terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

# Example: Creating AWS S3 Buckets using a loop
variable "bucket_count" {
  description = "Number of S3 buckets to create"
  type        = number
  default     = 2  # Default to creating 2 buckets, change as needed
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "access_key" {
  description = "AWS access key"
  type        = string
}

variable "secret_key" {
  description = "AWS secret key"
  type        = string
}

variable "bucket_names" {
  description = "List of S3 bucket names"
  type        = list(string)
  default     = ["example-bucket-1", "example-bucket-2"]  # Default bucket names, change as needed
}

resource "aws_s3_bucket" "example" {
  count = var.bucket_count

  bucket = var.bucket_names[count.index]

  tags = {
    Name = var.bucket_names[count.index]
    Environment = var.TF_VAR_environment  # Corrected variable reference
  }
}
