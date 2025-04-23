provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "Nandkishor"
  force_destroy = true

  tags = {
    Name        = "Test S3 Bucket"
    Environment = "Dev"
  }
}

