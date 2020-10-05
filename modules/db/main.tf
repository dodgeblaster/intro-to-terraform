provider "aws" {
  region = "us-east-2"
}

resource "aws_dynamodb_table" "terra-test-table" {
  name         = var.dbname
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "PK"
  range_key    = "SK"

  attribute {
    name = "PK"
    type = "S"
  }

  attribute {
    name = "SK"
    type = "S"
  }

  tags = {
    Name        = var.dbname
    Environment = "production"
  }
}

output "s3_bucket_arn" {
  value       = aws_dynamodb_table.terra-test-table.arn
  description = "The ARN of the DynamoDB Table"
}
