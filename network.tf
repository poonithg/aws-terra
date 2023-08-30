#### NETWORK CONFIGURATION FILE ####
# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc-cidr
  enable_dns_hostnames = true

  tags = {
    Name       = var.vpc
    MANAGED_BY = "TERRAFORM"
  }
}

# Internet Gateway for Public Subnet
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name       = var.ig
    MANAGED_BY = "TERRAFORM"
  }
}

# Elastic-IP (eip) for NAT
resource "aws_eip" "nat_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.ig]
}

# NAT
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name       = var.nat
    MANAGED_BY = "TERRAFORM"
  }
}

# Public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet-cidr-pub
  availability_zone       = var.subnet-cidr-pub-az
  map_public_ip_on_launch = true

  tags = {
    Name       = var.subnet-pub
    MANAGED_BY = "TERRAFORM"
  }
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet-cidr-priv
  availability_zone       = var.subnet-cidr-priv-az
  map_public_ip_on_launch = false

  tags = {
    Name       = var.subnet-priv
    MANAGED_BY = "TERRAFORM"
  }
}

# Routing tables to route traffic for Private Subnet
resource "aws_route_table" "route-priv" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name       = var.route-table-priv
    MANAGED_BY = "TERRAFORM"
  }
}

# Routing tables to route traffic for Public Subnet
resource "aws_route_table" "route-pub" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name       = var.route-table-pub
    MANAGED_BY = "TERRAFORM"
  }
}

# Route for Internet Gateway
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.route-pub.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}

# Route for NAT
resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.route-priv.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# Route table associations for both Public & Private Subnets
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route-pub.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.route-priv.id
}

