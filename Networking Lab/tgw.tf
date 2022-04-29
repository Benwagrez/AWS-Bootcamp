resource "aws_ec2_transit_gateway" "tgw1" {
  description = "demo_tgw"
  tags = {
    Name = "tgw1"
    Owner = "YourName/CLI"
    Key = "DoNotChangeThis"
  }
}


# TGW Route Table
resource "aws_ec2_transit_gateway_route" "tgw_default_route" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw1_attach_edge.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway.tgw1.association_default_route_table_id
}