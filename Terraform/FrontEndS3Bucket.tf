resource "aws_s3_bucket" "frontend" {
  bucket = "corporateawsapp-frontend"

  tags = {
    application = "corporateAWSApp"
  }
}

resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.frontend.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_public_access_block" "publicaccess" {
  bucket = aws_s3_bucket.frontend.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "s3_acl" {
    depends_on = [
          aws_s3_bucket_ownership_controls.ownership,
            aws_s3_bucket_public_access_block.publicaccess,
  ]

  bucket = aws_s3_bucket.frontend.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.frontend.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "app/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}