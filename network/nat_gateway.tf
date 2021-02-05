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
# # Elastic IP for NAT Gateway
# #####################################
# resource "aws_eip" "gw_eip_az1" {
#   vpc = true

#   tags = {
#     Name = "[${var.network_name}] gw_eip_az1"
#   }
# }

# resource "aws_eip" "gw_eip_az2" {
#   vpc = true

#   tags = {
#     Name = "[${var.network_name}] gw_eip_az2"
#   }
# }
