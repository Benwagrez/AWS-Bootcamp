
####################
## TRANSIT GATEWAY #
####################
#
#resource "aws_ec2_transit_gateway" "tgw" {
#  description = "transit gateway vpc1"
#  provider = var.region
#}
#
#
##resource "aws_ec2_transit_gateway" "tgw-vpc2" {
##  description = "transit gateway vpc2"
##  provider = var.aws_region_b
##}
#
###############################
## TRANSIT GATEWAY ATTACHMENT #
###############################
#
#resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-attachment-vpc01" {
#  subnet_ids         = [aws_subnet.aws-ds-vpc01-subnet01.id, aws_subnet.aws-ds-vpc01-subnet02.id]
#  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
#  vpc_id             = aws_vpc.dc-vpc.id
#}
#
#resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-attachment-vpc02" {
#  subnet_ids         = [aws_subnet.aws-onprem-vpc01-subnet01.id, aws_subnet.aws-onprem-vpc01-subnet02.id]
#  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
#  vpc_id             = aws_vpc.onprem-vpc.id
#}
#
#
##resource "aws_ec2_transit_gateway_peering_attachment" "tgw-peering-attachment" {
##  peer_account_id         = aws_ec2_transit_gateway.tgw-vpc2.owner_id
##  peer_region             = var.aws_region
##  peer_transit_gateway_id = aws_ec2_transit_gateway.tgw-vpc1.id
##  transit_gateway_id      = aws_ec2_transit_gateway.tgw-vpc2.id
##
##  tags = {
##    Name = "AWS-DS-VPC01&AWS-OnPrem-VPC01-Peer"
##  }
##}
#
##
#resource "aws_ec2_transit_gateway_connect" "ec2_tg_connect" {
#  transport_attachment_id = aws_ec2_transit_gateway_vpc_attachment.tgw-attachment-vpc01.id
#  transit_gateway_id      = aws_ec2_transit_gateway.tgw.id
#  tags = {
#    Name = "AWS-DS-VPC01&AWS-OnPrem-VPC01-Peer"
#  }
#}
#
#resource "aws_ec2_transit_gateway_connect_peer" "example" {
#  peer_address                  = aws_vpc.dc-vpc.ipv4_ipam_pool_id
#  inside_cidr_blocks            = "169.254.0.0/29"
#  transit_gateway_attachment_id = aws_ec2_transit_gateway_connect.ec2_tg_connect.id
#}
#
#
#resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "accepter_tg" {
#  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.tgw-attachment-vpc01.id
#}
#
##----------------------------------------------------------------------------------------------------
#



#################
#  VPC PEERING  #
#################

resource "aws_vpc_peering_connection" "peering_connection" {
  peer_vpc_id = aws_vpc.onprem-vpc.id
  vpc_id      = aws_vpc.dc-vpc.id
  auto_accept = true

  tags = {
    Name = "AWS-DS-VPC01&AWS-OnPrem-VPC01-Peer"
  }
}
#----------------------------------------------------------------------------------------------------

####################
# INTERNET GATEWAY #
####################

resource "aws_internet_gateway" "ds-gw" {
  vpc_id = aws_vpc.dc-vpc.id

  tags = {
    Name = "DS internet gateway"
  }
}

resource "aws_internet_gateway" "onprem-gw" {
  vpc_id = aws_vpc.onprem-vpc.id

  tags = {
    Name = "OnPrem internet gateway"
  }
}
#------------------------------------------------------------------------------------------------------