terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "suhas-ci-cd-terraform-state-bucket"
    key            = "github-actions-demo/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
    dynamodb_table = "demo-terraform-state-locking" # Create this table ONCE in Account B
  }
}


provider "aws" {
  region = "eu-north-1"
}

resource "aws_s3_bucket" "my_demo_bucket" {
  bucket = "suhas-github-actions-demo-bucket-2025-07-26-xyz12"
  tags = {
    Name        = "GitHubActionsDemoBucket1"
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
  description = "The ARN of the created S3 bucket......"
  value       = aws_s3_bucket.my_demo_bucket.arn
}
