
resource "aws_vpc" "vpc1" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "vpc1"
  }
}

resource "aws_subnet" "vpc1_subnet1" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "${var.region}a"
  tags = {
    Name = "vpc1_subnet1"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw1_attach_vpc1" {
  subnet_ids         = [ aws_subnet.vpc1_subnet1.id ]
  transit_gateway_id = aws_ec2_transit_gateway.tgw1.id
  vpc_id             = aws_vpc.vpc1.id
}

resource "aws_route_table" "vpc1_rtable" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "vpc1_rtable"
  }
}

resource "aws_route" "vpc1_internet_access" {
  route_table_id         = aws_route_table.vpc1_rtable.id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = aws_ec2_transit_gateway.tgw1.id
}

resource "aws_route" "vpc1_alt_tgw_access" {
  route_table_id         = aws_route_table.vpc1_rtable.id
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id     = aws_ec2_transit_gateway.tgw1.id
  }

# Route Table Associations
resource "aws_route_table_association" "vpc1_rtable_association" {
  subnet_id      = aws_subnet.vpc1_subnet1.id
  route_table_id = aws_route_table.vpc1_rtable.id
}
