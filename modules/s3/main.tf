terraform {
  backend "s3" {
    bucket = "my-s3-bucket"
    key = "dev/aws_s3"
    region = "ap-southeast-1"
  }
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = ">~3.0"
    }
  }

  required_version = ">= 1.0.0"
}