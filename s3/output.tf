output "fundamental_bucket" {
  value = {
    "access_logs" = aws_s3_bucket.access_logs.id
  }
}
