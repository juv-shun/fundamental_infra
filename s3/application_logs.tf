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

resource "aws_s3_bucket_policy" "application_logs" {
  bucket = aws_s3_bucket.application_logs.id
  policy = data.aws_iam_policy_document.application_logs.json
}

resource "aws_s3_bucket_public_access_block" "application_logs" {
  bucket                  = aws_s3_bucket.application_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "application_logs" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.application_logs.id}/*"]

    principals {
      type        = "AWS"
      identifiers = ["582318560864"]
    }
  }
}
