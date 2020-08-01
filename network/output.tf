output "aws_vpc_subnet_ids" {
  value = map(
    "vpc_main", aws_vpc.main.id,
    "public_subnet_az1", aws_subnet.public_subnet_az1.id,
    "public_subnet_az2", aws_subnet.public_subnet_az2.id,
    "private_subnet_az1", aws_subnet.private_subnet_az1.id,
    "private_subnet_az2", aws_subnet.private_subnet_az2.id,
  )
}

output "aws_vpc_subnet_cidrs" {
  value = map(
    "vpc_main", "172.16.0.0/16",
    "public_subnet_az1", "172.16.1.0/24",
    "public_subnet_az2", "172.16.2.0/24",
    "private_subnet_az1", "172.16.3.0/24",
    "private_subnet_az2", "172.16.4.0/24",
  )
}
