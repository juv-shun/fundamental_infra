resource "aws_s3_bucket" "application_logs" {
  bucket = "${var.account_name}.application-logs"

  lifecycle_rule {
    id      = "delete object that elapsed 30 days"
    enabled = true

    expiration {
      days = 30
    }
  }
}
resource "aws_s3_bucket_public_access_block" "application_logs" {
  bucket                  = aws_s3_bucket.application_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_iam_policy" "put_application_log_bucket_policy" {
  name = "${var.account_name}-put_application_log_bucket_policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowAccessToS3ApplicationLogBucket",
            "Effect": "Allow",
            "Action": [
              "s3:ListObject",
              "s3:GetObject",
              "s3:PutObject",
              "s3:DeleteObject"
            ],
            "Resource": [
               "arn:aws:s3:::${aws_s3_bucket.application_logs.id}/*"
            ]
        }
    ]
}
EOF
}
