terraform {
  required_providers {
    aws = "~> 2.58"
  }
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.app_name} VPC"
  }
}

resource "aws_subnet" "public_subnets" {
  count = var.az_number

  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 2, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = format("public-%s", data.aws_availability_zones.available.names[count.index])
  }
}

resource "aws_subnet" "private_subnets" {
  count = var.az_number

  vpc_id            = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 2, count.index + var.az_number)
  tags = {
    Name = format("private-%s", data.aws_availability_zones.available.names[count.index])
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_route_table_accociation" {
  count = length(aws_subnet.public_subnets)

  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_eip" "eip" {
  count = length(aws_subnet.private_subnets)
  vpc   = true
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "private_route_table_accociation" {
  count = length(aws_subnet.private_subnets)

  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = aws_route_table.private_route_table.id
}
