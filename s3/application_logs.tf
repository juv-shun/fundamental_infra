resource "aws_s3_bucket" "application_logs" {
  bucket = "${var.service_name}.application-logs"

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
  name = "${var.service_name}-put_application_log_bucket_policy"
  policy = data.aws_iam_policy_document.application_logs.json
}

data "aws_iam_policy_document" "application_logs" {
  statement {
    effect    = "Allow"
    sid       = "AllowAccessToS3ApplicationLogBucket"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.application_logs.id}/*"]
  }
}
