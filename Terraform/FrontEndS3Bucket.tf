resource "aws_s3_bucket" "frontend" {
  bucket = "corporateawsapp-frontend"
  force_destroy = true

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

// There are two ways to create a policy, I am using here the heredoc format. 
// Read here for more information: https://developer.hashicorp.com/terraform/tutorials/aws/aws-iam-policy

resource "aws_s3_bucket_policy" "s3_website_policy" {
  bucket      = aws_s3_bucket.frontend.id
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject"
        ],
      "Resource": [
        "${aws_s3_bucket.frontend.arn}/*"
        ]
    }
  ]
}
EOF
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.frontend.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}