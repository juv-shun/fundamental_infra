output "security_group_ids" {
  value = map(
    "default", aws_default_security_group.default.id,
    "ssh", aws_security_group.ssh.id,
  )
}

output "general_key_pair" {
  value = aws_key_pair.general_key.key_name
}
