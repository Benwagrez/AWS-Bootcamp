# Create AWS VPC Object edge vpc3
resource "aws_vpc" "edge_vpc3" {
  cidr_block = "10.3.0.0/16" # Setting the CIDR block for the VPC
  tags = { # Setting tags (default tags as defined in variables gets appended to tags)
    Name = "edge_vpc3"
  }
}

# Create AWS subnet for edge vpc3
# The subnet does not affect the ending infrastructure of this lab
# Instead it sets the foundations for routing and the ability to add
# compute to the VPCs in the future (i.e., EC2 Instances)
resource "aws_subnet" "vpc3_subnet1" {
  vpc_id                  = aws_vpc.edge_vpc3.id # Associating the subnet with a VPC
  cidr_block              = "10.3.3.0/24" # Setting a subnet within the VPCs CIDR block
  map_public_ip_on_launch = false
  availability_zone       = "${var.region}a"
  tags = {
    Name = "edge_vpc3_subnet1"
  }
}

# Create Internal Route Table
resource "aws_route_table" "edge_vpc3_internal_rtable" {
  vpc_id = aws_vpc.edge_vpc3.id # Associate the routing table with the edge vpc
  tags = {
    Name = "edge_vpc3_internal_rtable"
  }
}

# Create Routing Table Association
resource "aws_route_table_association" "nat_internal_association" {
  # Associate the routing table with the subnet created for edge vpc
  subnet_id      = aws_subnet.vpc3_subnet1.id
  # Select the routing table just created for edge vpc
  route_table_id = aws_route_table.edge_vpc3_internal_rtable.id
}

resource "aws_route" "edge_vpc_routes" {
  # Associate the route with the routing table just created for edge vpc
  route_table_id = aws_route_table.edge_vpc3_internal_rtable.id
  # Set a destination IP block that includes the IPs of all over VPCs
  destination_cidr_block = "10.0.0.0/8"
  # Set a transit gateway as the destination next-hop
  transit_gateway_id     = aws_ec2_transit_gateway.tgw1.id
}