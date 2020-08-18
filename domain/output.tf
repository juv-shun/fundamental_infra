output "aws_vpc_subnet_ids" {
  value = {
    public_host  = aws_route53_zone.public.zone_id
    private_host = aws_route53_zone.private.zone_id
  }
}
