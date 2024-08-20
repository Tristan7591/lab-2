resource "aws_vpc" "VPCA" {
  cidr_block           = "12.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "VPCA"
  }
}

resource "aws_vpc" "VPCB" {
  cidr_block           = "13.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "VPCB"
  }
}

resource "aws_subnet" "subnet_public_A" {
  vpc_id            = aws_vpc.VPCA.id
  cidr_block        = "12.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-public-VPCA"
  }
}

resource "aws_subnet" "subnet_public_B" {
  vpc_id            = aws_vpc.VPCB.id
  cidr_block        = "13.0.1.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-public-VPCB"
  }
}

resource "aws_internet_gateway" "igw_A" {
  vpc_id = aws_vpc.VPCA.id

  tags = {
    Name = "igw-VPCA"
  }
}

resource "aws_internet_gateway" "igw_B" {
  vpc_id = aws_vpc.VPCB.id

  tags = {
    Name = "igw-VPCB"
  }
}

resource "aws_route_table" "route_table_A" {
  vpc_id = aws_vpc.VPCA.id

  tags = {
    Name = "route-table-VPCA"
  }
}

resource "aws_route_table" "route_table_B" {
  vpc_id = aws_vpc.VPCB.id

  tags = {
    Name = "route-table-VPCB"
  }
}

resource "aws_route_table_association" "route_table_association_A" {
  subnet_id      = aws_subnet.subnet_public_A.id
  route_table_id = aws_route_table.route_table_A.id
}

resource "aws_route_table_association" "route_table_association_B" {
  subnet_id      = aws_subnet.subnet_public_B.id
  route_table_id = aws_route_table.route_table_B.id
}

resource "aws_route" "route_A" {
  route_table_id         = aws_route_table.route_table_A.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_A.id
}

resource "aws_route" "route_B" {
  route_table_id         = aws_route_table.route_table_B.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_B.id
}

