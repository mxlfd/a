terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.38.0"
    }
  }
}

####################################
variable "AWS_ACCESS_KEY_ID" {
  sensitive = true
}

variable "AWS_SECRET_ACCESS_KEY" {
  sensitive = true
}

####################################
provider "aws" {
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  region     = "us-west-2"
}

####################################


resource "aws_s3_bucket" "test" {

  bucket = "ml-terraformstatetesting-1234"
  tags = {
    X = "y"
  }
}



# $ export AWS_ACCESS_KEY_ID="anaccesskey"
# $ export AWS_SECRET_ACCESS_KEY="asecretkey"
# see 1password for details
# 