resource "aws_vpc" "edge_vpc3" {
  cidr_block = "10.3.0.0/16"
  tags = {
    Name = "edge vpc3"
    Owner = "YourName/CLI"
    Key = "DoNotChangeThis"
  }
}

# Create an IGW 
resource "aws_internet_gateway" "edge_vpc_igw" {
  vpc_id = aws_vpc.edge_vpc3.id
}

# Define a NAT subnet primary availability zone
resource "aws_subnet" "edge_vpc3_external_subnet1" {
  vpc_id                  = aws_vpc.edge_vpc3.id
  cidr_block              = "10.3.1.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "${var.region}a"
  tags = {
    Name = "edge_vpc3_external_subnet1"
    Owner = "YourName/CLI"
    Key = "DoNotChangeThis"
  }
}

# Define a NAT subnet primary availability zone
resource "aws_subnet" "edge_vpc3_internal_subnet1" {
  vpc_id                  = aws_vpc.edge_vpc3.id
  cidr_block              = "10.3.3.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "${var.region}a"
  tags = {
    Name = "edge_vpc3_internal_subnet1"
    Owner = "YourName/CLI"
    Key = "DoNotChangeThis"
  }
}

# Define a Web server Internal subnet
# resource "aws_subnet" "edge_web_subnet_1a" {
#   vpc_id                  = aws_vpc.edge_vpc3.id
#   cidr_block              = "10.3.5.0/24"
#   map_public_ip_on_launch = false
#   availability_zone       = "${var.region}a"
#   tags = {
#     Name = "Edge_VPC_Web_Subnet_1A"
#   }
# }

# Attach  TGW to Edge VPC
resource "aws_ec2_transit_gateway_vpc_attachment" "tgw1_attach_edge" {
  subnet_ids         = [ aws_subnet.edge_vpc3_internal_subnet1.id ]
  transit_gateway_id = aws_ec2_transit_gateway.tgw1.id
  vpc_id             = aws_vpc.edge_vpc3.id
}

# Create a Public route table

resource "aws_route_table" "edge_vpc3_pub_rtable" {
  vpc_id = aws_vpc.edge_vpc3.id
  # Route to the internet
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.edge_vpc_igw.id
  }
  tags = {
    Name = "edge_vpc3_pub_rtable"
    Owner = "YourName/CLI"
    Key = "DoNotChangeThis"
  }
}

resource "aws_route_table_association" "edge_vpc3_pub_rtable_association" {
  subnet_id      = aws_subnet.edge_vpc3_external_subnet1.id
  route_table_id = aws_route_table.edge_vpc3_pub_rtable.id
}

# Create Internal Route Table
resource "aws_route_table" "edge_vpc3_internal_rtable" {
  vpc_id = aws_vpc.edge_vpc3.id
  tags = {
    Name = "edge_vpc3_internal_rtable"
    Owner = "YourName/CLI"
    Key = "DoNotChangeThis"
  }
}

# Create Default route
# resource "aws_route" "defaultroute" {
#   route_table_id         = aws_route_table.edge_vpc3_internal_rtable.id
#   destination_cidr_block = "0.0.0.0/0"
#   network_interface_id   = aws_network_interface.nat_nic2.id
#   #instance_id = aws_instance.vpc_edge_web1.id
# }

resource "aws_route_table_association" "nat_internal_association" {
  subnet_id      = aws_subnet.edge_vpc3_internal_subnet1.id
  route_table_id = aws_route_table.edge_vpc3_internal_rtable.id
}

# resource "aws_route_table_association" "web_sub_association" {
#   subnet_id      = aws_subnet.edge_web_subnet_1a.id
#   route_table_id = aws_route_table.edge_vpc3_internal_rtable.id
# }

resource "aws_route" "edge_vpc_routes" {
    route_table_id = aws_route_table.edge_vpc3_internal_rtable.id
    destination_cidr_block = "10.0.0.0/8"
    transit_gateway_id     = aws_ec2_transit_gateway.tgw1.id
   }