terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.38.0"
    }
  }
}


# $ export AWS_ACCESS_KEY_ID="anaccesskey"
# $ export AWS_SECRET_ACCESS_KEY="asecretkey"
# see 1password for details


####################################
provider "aws" {
  region     = "us-west-2"
}

####################################


resource "aws_s3_bucket" "terraform_state" {

  bucket = "terraform-backend-7473495794370"

  lifecycle {
    prevent_destroy = true   # not deleteable
  }
}


resource "aws_s3_bucket_versioning" "enabled" {

  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {

  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


resource "aws_s3_bucket_public_access_block" "public_access" {

  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}



resource "aws_dynamodb_table" "terraform_locks" {

  name         = "terraform-backend-locks-324293847"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}








# write whole flow step by step to audience
# 
# output plan in pull request ugly
#
# remote backend - will it work