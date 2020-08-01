#####################################
# VPC Settings
#####################################
resource "aws_vpc" "main" {
  cidr_block           = "172.16.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main"
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
    Name = "[main] public_subnet_az1"
  }
}

## zone az2
resource "aws_subnet" "public_subnet_az2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "172.16.2.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "[main] public_subnet_az2"
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
    Name = "[main] private_subnet_az1"
  }
}

## zone az2
resource "aws_subnet" "private_subnet_az2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "172.16.4.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "[main] private_subnet_az2"
  }
}

#####################################
# Internet Gateway Settings
#####################################
resource "aws_internet_gateway" "i_gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main"
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
    Name = "main"
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
