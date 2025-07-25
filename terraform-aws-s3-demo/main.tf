# Configure the AWS Provider
# This block tells Terraform that we want to manage resources in AWS
# and specifies the region where these resources should be created.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Use a compatible version of the AWS provider
    }
  }
}

provider "aws" {
  region = "eu-central-1" # Set your desired AWS region (e.g., "us-east-1", "eu-west-1")
}

# Define an AWS S3 Bucket resource
# This block declares that we want to create an S3 bucket.
# The `resource` keyword is followed by the resource type ("aws_s3_bucket")
# and a local name ("my_demo_bucket") for referencing it within Terraform.
resource "aws_s3_bucket" "my_demo_bucket" {
  # The bucket name must be globally unique across all AWS accounts.
  # For a demo, you can append a unique string or a timestamp.
  # Using `random_id` is a good practice to ensure uniqueness.
  bucket = "my-github-actions-demo-bucket-2025-07-25-unique-suffix" # Replace with something unique or use a random suffix

  # Add tags for organization and identification
  tags = {
    Name        = "GitHubActionsDemoBucket"
    Environment = "Dev"
    ManagedBy   = "Terraform"
  }
}

# Define an S3 bucket ownership controls resource
# This is often needed with newer AWS provider versions to ensure proper ACL behavior.
resource "aws_s3_bucket_ownership_controls" "my_demo_bucket_ownership" {
  bucket = aws_s3_bucket.my_demo_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Define an S3 bucket public access block resource
# This is highly recommended for security to prevent accidental public access.
resource "aws_s3_bucket_public_access_block" "my_demo_bucket_public_access_block" {
  bucket = aws_s3_bucket.my_demo_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Output the S3 bucket name and ARN after creation
# Outputs are useful for displaying important information after Terraform applies changes.
output "bucket_name" {
  description = "The name of the created S3 bucket"
  value       = aws_s3_bucket.my_demo_bucket.bucket
}

output "bucket_arn" {
  description = "The ARN of the created S3 bucket"
  value       = aws_s3_bucket.my_demo_bucket.arn
}
