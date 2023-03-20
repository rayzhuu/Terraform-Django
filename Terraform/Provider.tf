## Provider for the US-EAST-1 region of AWS
provider "aws" {
  region = var.region
}

### Networking Resources for the application

# Production VPC

resource "aws_vpc" "production-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# public subnets

resource "aws_subnets" "public-subnet-1" {
  cidr_block        = var.public_subnet_1_cidr
  vpc_id            = aws_production-vpc.id
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "Public subnet 1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  cidr_block        = var.public_subnet_2_cidr
  vpc_id            = aws_vpc.production-vpc.id
  availability_zone = var.availability_zone[1]

  tags = {
    Name = "Public subnet 2"
  }
}

# private subnets
resource "aws_subnet" "private-subnet-1" {
  cidr_block        = var.private_subnet_1_cidr
  vpc_id            = aws_vpc.production-vpc.id
  availability_zone = var.availability_zone[2]

  tags = {
    Name = "Private subnet 1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  cidr_block        = var.private_subnet_2_cidr
  vpc_id            = aws_vpc.production-vpc.id
  availability_zone = var.availability_zone[3]

  tags = {
    Name = "Private subnet 2"
  }
}

# Route tables for the subnets
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.production-vpc.id

}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.production-vpc.id

}

# Route table association
resource "aws_route_table_association" "public-route-1-association" {
  subnet_id      = aws_subnet.public-subnet-1
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-route-2-association" {
  subnet_id      = aws_subnet.public-subnet-2
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "private-route-1-association" {
  subnet_id      = aws_subnet.private-subnet-1
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "private-route-2-association" {
  subnet_id      = aws_subnet.private-subnet-2
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_eip" "elastic-ip-for-nat-gw" {
  vpc                       = true
  associate_with_private_ip = "10.0.0.5"
  depends_on = [aws_internet_gateway.production-igw
  ]
}
