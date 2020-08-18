resource "aws_route53_zone" "public" {
  name = var.host_zone
}

resource "aws_route53_zone" "private" {
  name = var.host_zone

  vpc {
    vpc_id = data.terraform_remote_state.network.outputs.aws_vpc_subnet_ids["vpc"]
  }
}
