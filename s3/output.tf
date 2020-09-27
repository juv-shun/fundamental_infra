output "fundamental_bucket" {
  value = {
    "access_logs"      = aws_s3_bucket.access_logs.id
    "application_logs" = aws_s3_bucket.application_logs.id
  }
}
