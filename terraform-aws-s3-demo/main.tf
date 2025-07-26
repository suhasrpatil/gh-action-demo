terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}


resource "aws_s3_bucket" "my_demo_bucket" {
  bucket = "suhas-github-actions-demo-bucket-2025-07-25-xyz"
  tags = {
    Name        = "GitHubActionsDemoBucket"
    Environment = "Dev"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_ownership_controls" "my_demo_bucket_ownership" {
  bucket = aws_s3_bucket.my_demo_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "my_demo_bucket_public_access_block" {
  bucket = aws_s3_bucket.my_demo_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


output "bucket_name" {
  description = "Demo S3 bucket"
  value       = aws_s3_bucket.my_demo_bucket.bucket
}

output "bucket_arn" {
  description = "The ARN of the created S3 bucket.."
  value       = aws_s3_bucket.my_demo_bucket.arn
}
