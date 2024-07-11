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

# Example: Environment-based resource counts
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

variable "environment" {
  description = "Environment type (dev or prod)"
  type        = string
  default     = "dev"  # Default to dev environment
}

resource "aws_s3_bucket" "example" {
  count = var.environment == "dev" ? 2 : 4  # Adjust counts based on environment

  bucket = "${var.environment}-example-bucket-${count.index + 1}"

  tags = {
    Name        = "${var.environment}-example-bucket-${count.index + 1}"
    Environment = var.environment
  }
}
