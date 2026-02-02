# 1. Required Providers 
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# 2. Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# 3. A Single Simple Resource for Testing
resource "aws_s3_bucket" "test_bucket" {
  # Change this to something unique to you!
  bucket = "my-bootcamp-test"

  tags = {
    Name        = "Test Bucket"
    Environment = "Dev"
    Project     = "K8s-Bootcamp"
  }
}