resource "aws_s3_bucket" "access_logs" {
  bucket = "${var.service_name}-access-logs"

  lifecycle_rule {
    id      = "delete object that elapsed 30 days"
    enabled = true

    expiration {
      days = 30
    }
  }
}
