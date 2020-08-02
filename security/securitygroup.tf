resource "aws_default_security_group" "default" {
  vpc_id = data.terraform_remote_state.network.outputs.aws_vpc_subnet_ids["vpc"]

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["172.16.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "[${var.service_name}] default"
  }
}

resource "aws_security_group" "ssh" {
  name        = "ssh"
  description = "Allow ssh access"
  vpc_id      = data.terraform_remote_state.network.outputs.aws_vpc_subnet_ids["vpc"]

  lifecycle {
    ignore_changes = [ingress]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "[${var.service_name}] ssh"
  }
}
