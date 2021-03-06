provider "aws" {
  region = "us-east-2"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Resources for keeping track of State
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
terraform {
  backend "s3" {
    bucket         = "garysjennings-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

resource "aws_s3_bucket" "garysjennings-terraform_state" {
  bucket = "garysjennings-terraform-state"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}



# - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Resources for app
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
module "db" {
  source = "../../modules/db"
  dbname = "terraform-dev"
}
