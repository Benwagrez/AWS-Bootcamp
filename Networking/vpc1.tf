
resource "aws_vpc" "vpc1" {
  # Fill in as shown in guide
}

resource "aws_subnet" "vpc1_subnet1" {
  # Fill in as shown in guide
}

resource "aws_route_table" "vpc1_rtable" {
  # Fill in as shown in guide
}

resource "aws_route" "vpc1_internet_access" {
  # Fill in as shown in guide
}

resource "aws_route" "vpc1_alt_tgw_access" {
  # Fill in as shown in guide
}

# Route Table Associations
resource "aws_route_table_association" "vpc1_rtable_association" {
  # Fill in as shown in guide
}
