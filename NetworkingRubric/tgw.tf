resource "aws_ec2_transit_gateway" "tgw1" {
  description = "demo_tgw"
  tags = {
    Name = "tgw1"
  }
}
# TGW Route Table
resource "aws_ec2_transit_gateway_route" "tgw_default_route" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw1_attach_edge.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway.tgw1.association_default_route_table_id
}

# Attach TGW to edge vpc3
resource "aws_ec2_transit_gateway_vpc_attachment" "tgw1_attach_edge" {
  subnet_ids         = [ aws_subnet.vpc3_subnet1.id ]
  transit_gateway_id = aws_ec2_transit_gateway.tgw1.id
  vpc_id             = aws_vpc.edge_vpc3.id
}

# Attach TGW to vpc1
resource "aws_ec2_transit_gateway_vpc_attachment" "tgw1_attach_vpc1" {
  subnet_ids         = [ aws_subnet.vpc1_subnet1.id ]
  transit_gateway_id = aws_ec2_transit_gateway.tgw1.id
  vpc_id             = aws_vpc.vpc1.id
}

# Attach TGW to vpc2
resource "aws_ec2_transit_gateway_vpc_attachment" "tgw1_attach_vpc2" {
  subnet_ids         = [ aws_subnet.vpc2_subnet1.id ]
  transit_gateway_id = aws_ec2_transit_gateway.tgw1.id
  vpc_id             = aws_vpc.vpc2.id
}