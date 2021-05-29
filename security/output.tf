output "security_group_ids" {
  value = {
    default = aws_default_security_group.default.id
  }
}

output "general_key_pair" {
  value = aws_key_pair.general_key.key_name
}
