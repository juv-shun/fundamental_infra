resource "aws_instance" "bastion" {
  ami                  = "ami-01c36f3329957b16a" # Ubuntu Server 18.04 LTS (HVM), SSD Volume Type
  instance_type        = "t2.micro"
  key_name             = data.terraform_remote_state.security.outputs.general_key_pair
  subnet_id            = data.terraform_remote_state.network.outputs.aws_vpc_subnet_ids["public_subnet_az1"]
  iam_instance_profile = aws_iam_instance_profile.bastion_profile.name
  vpc_security_group_ids = [
    data.terraform_remote_state.security.outputs.security_group_ids["default"],
    data.terraform_remote_state.security.outputs.security_group_ids["ssh"],
  ]
  associate_public_ip_address = true
  user_data                   = <<EOF
#!/bin/bash
sudo timedatectl set-timezone Asia/Tokyo
EOF

  tags = {
    Name = var.server_name
  }
}

resource "aws_iam_instance_profile" "bastion_profile" {
  name = var.server_name
  role = aws_iam_role.bastion_role.name
}

resource "aws_iam_role" "bastion_role" {
  name = var.server_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "bastion-attach-ro" {
  role       = aws_iam_role.bastion_role.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}
