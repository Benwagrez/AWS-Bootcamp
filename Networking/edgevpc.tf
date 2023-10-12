# Create AWS VPC Object edge vpc3
resource "aws_vpc" "edge_vpc3" {
  # Create new VPC object
}

# Create AWS subnet for edge vpc3
# The subnet does not affect the ending infrastructure of this lab
# Instead it sets the foundations for routing and the ability to add
# compute to the VPCs in the future (i.e., EC2 Instances)
resource "aws_subnet" "vpc3_subnet1" {
  # Create subnet for third VPC object
}

# Create Internal Route Table
resource "aws_route_table" "edge_vpc3_internal_rtable" {
  # Create routing table for above subnet
}

# Create Routing Table Association
resource "aws_route_table_association" "nat_internal_association" {
  # Create routing table association for the routing table
}

resource "aws_route" "edge_vpc_routes" {
  # Create associated route
}