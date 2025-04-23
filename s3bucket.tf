provider "aws" {
  region = "ap-south-1"
FILE_NAME = 's3bucket.tf'
}
resource "aws_s3_bucket" "my_bucket" {
  bucket = "nandkishor-999"  # Yeh naam globally unique hona chahiye
  acl    = "private"  # Bucket ka access control (private, public-read, etc.)
 tags = {
    Name        = "MyS3Bucket"
    Environment = "Development"
    Project     = "Terraform Demo"
  }
}



