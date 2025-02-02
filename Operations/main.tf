provider "aws" {
    region = "us-west-2"
}

resource "aws_dynamodb_table" "terraform_lock" {
    name         = "state-lock-table"
    billing_mode = "PAY_PER_REQUEST"
    hash_key     = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
}