#####################################
# VPC Settings
#####################################
resource "aws_vpc" "main" {
  cidr_block           = "172.16.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.network_name
  }
}

#####################################
# Public Subnets Settings
#####################################
## zone az1
resource "aws_subnet" "public_subnet_az1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "172.16.1.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "[${var.network_name}] public_subnet_az1"
  }
}

## zone az2
resource "aws_subnet" "public_subnet_az2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "172.16.2.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "[${var.network_name}] public_subnet_az2"
  }
}

#####################################
# Private Subnets Settings
#####################################
## zone az1
resource "aws_subnet" "private_subnet_az1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "172.16.3.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "[${var.network_name}] private_subnet_az1"
  }
}

## zone az2
resource "aws_subnet" "private_subnet_az2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "172.16.4.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "[${var.network_name}] private_subnet_az2"
  }
}

#####################################
# Internet Gateway Settings
#####################################
resource "aws_internet_gateway" "i_gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = var.network_name
  }
}

#####################################
# Routes Table Settings
#####################################
resource "aws_route_table" "igw_route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.i_gw.id
  }
  tags = {
    Name = "${var.network_name}_igw"
  }
}

resource "aws_route_table" "nat_route_az1" {
  vpc_id = aws_vpc.main.id

  # route {
  #   cidr_block     = "0.0.0.0/0"
  #   nat_gateway_id = aws_nat_gateway.nat_gw_az1.id
  # }

  tags = {
    Name = "${var.network_name}_natgw_az1"
  }
}

resource "aws_route_table" "nat_route_az2" {
  vpc_id = aws_vpc.main.id

  # route {
  #   cidr_block     = "0.0.0.0/0"
  #   nat_gateway_id = aws_nat_gateway.nat_gw_az2.id
  # }

  tags = {
    Name = "${var.network_name}_natgw_az2"
  }
}

#####################################
# Routes Association Settings
#####################################
resource "aws_route_table_association" "i_gw_association_az1" {
  subnet_id      = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.igw_route.id
}

resource "aws_route_table_association" "i_gw_association_az2" {
  subnet_id      = aws_subnet.public_subnet_az2.id
  route_table_id = aws_route_table.igw_route.id
}

resource "aws_route_table_association" "nat_association_az1" {
  subnet_id      = aws_subnet.private_subnet_az1.id
  route_table_id = aws_route_table.nat_route_az1.id
}

resource "aws_route_table_association" "rt_association_az2" {
  subnet_id      = aws_subnet.private_subnet_az2.id
  route_table_id = aws_route_table.nat_route_az2.id
}
