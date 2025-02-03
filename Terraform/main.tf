terraform {
    backend "s3" {
        bucket         = "corporateapp-terraformstate"
        key            = "terraform.tfstate"
        region         = "us-west-2"
        dynamodb_table = "state-lock-table"
        encrypt        = true
    }

    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.84"
        }
    }

    required_version = ">= 0.14"
}

provider "aws" {
    region = "us-west-2"
}

