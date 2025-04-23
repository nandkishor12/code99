provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-nw-test-bucket-123456"
  force_destroy = true

  tags = {
    Name        = "MyTestBucket"
    Environment = "Dev"
  }
}
