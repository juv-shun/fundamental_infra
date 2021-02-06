output "fundamental_bucket" {
  value = {
    "access_logs" = aws_s3_bucket.access_logs.id
    "application_logs" = {
      "bucket_name"       = aws_s3_bucket.application_logs.id
      "access_policy_arn" = aws_iam_policy.put_application_log_bucket_policy.arn
    }
  }
}
