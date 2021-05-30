#####################################
# VPC Endpoint (S3) Settings
#####################################
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.ap-northeast-1.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.nat_route_az1.id,
    aws_route_table.nat_route_az2.id,
  ]

  tags = {
    Name = "[${var.service_name}] vpc_endpoint_s3"
  }
}
