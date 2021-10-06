#  terraform {
#   backend "s3" {
#     bucket = "binnubucket"
#     key    = "terraform.tfstate"
#     region = "us-east-1"
#     profile = "default"
#     shared_credentials_file = "D:/.aws/credentials"
#   }

#    required_providers {
#     aws = {
#        source  = "hashicorp/aws"
#        version = "~> 3.27"
#      }
#    }

#    required_version = ">= 1.0.6"
#  }

 provider "aws" {
   profile = "default"
   region  = var.region
#  shared_credentials_file = "D:/.aws/credentials"
}

resource "aws_s3_bucket" "b" {
  bucket = "binnubucket"
  acl    = "private"

  tags = {
    Name        = "binnubucket"
  }
}