resource "aws_vpc" "vpc2" {
  cidr_block       = "10.2.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "vpc2"
  }
}

resource "aws_subnet" "vpc2_subnet1" {
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = "10.2.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "${var.region}a"
  tags = {
    Name = "vpc2_subnet1"
  }
}

resource "aws_route_table" "vpc2_rtable" {
  vpc_id = aws_vpc.vpc2.id
}

resource "aws_route" "vpc2_internet_access" {
  route_table_id         = aws_route_table.vpc2_rtable.id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = aws_ec2_transit_gateway.tgw1.id
}

resource "aws_route" "vpc2_alt_tgw_access" {
  route_table_id         = aws_route_table.vpc2_rtable.id
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id     = aws_ec2_transit_gateway.tgw1.id
  }

# Route Table Associations
resource "aws_route_table_association" "vpc2_rtable_association" {
  subnet_id      = aws_subnet.vpc2_subnet1.id
  route_table_id = aws_route_table.vpc2_rtable.id
}