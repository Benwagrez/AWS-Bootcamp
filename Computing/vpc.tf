########
# VPC  #
########

resource "aws_vpc" "dc-vpc" {
  cidr_block       = var.aws_ds_cidr_block
  instance_tenancy = "default"
  tags = {
    Name = "vpc1"
  }
}

resource "aws_vpc" "onprem-vpc" {
  cidr_block       = var.aws_onprem_cidr_block
  instance_tenancy = "default"
  tags = {
    Name = "vpc2"
  }
}

#---------------------------------------------------------------------------

###############
#   SUBNETS   #
###############

resource "aws_subnet" "aws-ds-vpc01-subnet01" {
  vpc_id                  = aws_vpc.dc-vpc.id
  cidr_block              = var.aws_dc_sub1_cidr_block
  map_public_ip_on_launch = false
  availability_zone       = "${var.region}a"
  tags = {
    Name = "vpc1_subnet1"
  }
}


resource "aws_subnet" "aws-ds-vpc01-subnet02" {
  vpc_id                  = aws_vpc.dc-vpc.id
  cidr_block              = var.aws_dc_sub02_cidr_block
  map_public_ip_on_launch = false
  availability_zone       = "${var.region}b"
  tags = {
    Name = "vpc1_subnet2"
  }
}

resource "aws_subnet" "aws-onprem-vpc01-subnet01" {
  vpc_id                  = aws_vpc.onprem-vpc.id
  cidr_block              = var.aws_onprem_sub1_cidr_block
  map_public_ip_on_launch = false
  availability_zone       = "${var.region}a"
  tags = {
    Name = "vpc2_subnet1"
  }
}

resource "aws_subnet" "aws-onprem-vpc01-subnet02" {
  vpc_id                  = aws_vpc.onprem-vpc.id
  cidr_block              = var.aws_onprem_sub2_cidr_block
  map_public_ip_on_launch = false
  availability_zone       = "${var.region}b"
  tags = {
    Name = "vpc2_subnet2"
  }
}

#-----------------------------------------------------------------------------------

################
# ROUTE TABLES #
################

resource "aws_route_table" "aws-ds-vpc01-rt" {
  vpc_id = aws_vpc.dc-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ds-gw.id
  }

  route {
    cidr_block                = var.aws_onprem_sub1_cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
  }

  tags = {
    Name = "RT-VPC01-DS"
  }
}

resource "aws_route_table" "aws-onprem-vpc01-rt" {
  vpc_id = aws_vpc.onprem-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.onprem-gw.id
  }

  route {
    cidr_block                = var.aws_dc_sub1_cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
  }

  tags = {
    Name = "RT-VPC02-OnPrem"
  }
}

resource "aws_main_route_table_association" "main_route_ds" {
  route_table_id = aws_route_table.aws-ds-vpc01-rt.id
  vpc_id         = aws_vpc.dc-vpc.id
}

resource "aws_main_route_table_association" "main_route_on_prem" {
  route_table_id = aws_route_table.aws-onprem-vpc01-rt.id
  vpc_id         = aws_vpc.onprem-vpc.id
}
