
provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {

    bucket = "terraform-backend-7473495794370"
    key    = "global/s3/terraform.tfstate"
    region = "us-west-2"

    dynamodb_table = "terraform-backend-locks-324293847"
    encrypt        = true
  }
}




resource "aws_s3_bucket" "test" {

  bucket = "ml-terraformstatetesting-2345"

  tags = {
    X = "y"
  }
}



# $ export AWS_ACCESS_KEY_ID="anaccesskey"
# $ export AWS_SECRET_ACCESS_KEY="asecretkey"
# see 1password for details
# 


# write whole flow step by step to audience
# 
# output plan in pull request ugly
#
# remote backend - will it work