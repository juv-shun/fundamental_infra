# #####################################
# # NAT Gateway Settings
# #####################################
# resource "aws_nat_gateway" "nat_gw_az1" {
#   allocation_id = aws_eip.gw_eip_az1.id
#   subnet_id     = aws_subnet.public_subnet_az1.id
# }

# resource "aws_nat_gateway" "nat_gw_az2" {
#   allocation_id = aws_eip.gw_eip_az2.id
#   subnet_id     = aws_subnet.public_subnet_az2.id
# }

# #####################################
# # Routes Table Settings
# #####################################
# resource "aws_route_table" "nat_route_az1" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.nat_gw_az1.id
#   }

#   tags = {
#     Name = "[${var.service_name}] nat_gw_az1"
#   }
# }

# resource "aws_route_table" "nat_route_az2" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.nat_gw_az2.id
#   }

#   tags = {
#     Name = "[${var.service_name}] nat_gw_az2"
#   }
# }

# #####################################
# # Routes Association Settings
# #####################################
# resource "aws_route_table_association" "rt_association_az1" {
#   subnet_id      = "${aws_subnet.private_subnet_az1.id}"
#   route_table_id = "${aws_route_table.nat_route_az1.id}"
# }

# resource "aws_route_table_association" "rt_association_az2" {
#   subnet_id      = "${aws_subnet.private_subnet_az2.id}"
#   route_table_id = "${aws_route_table.nat_route_az2.id}"
# }

# #####################################
# # Elastic IP for NAT Gateway
# #####################################
# resource "aws_eip" "gw_eip_az1" {
#   vpc = true

#   tags = {
#     Name = "[${var.service_name}] gw_eip_az1"
#   }
# }

# resource "aws_eip" "gw_eip_az2" {
#   vpc = true

#   tags = {
#     Name = "[${var.service_name}] gw_eip_az2"
#   }
# }
