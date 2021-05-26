terraform {
  required_version = ">= 0.12"
}

######### VPC ##########
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = false
  enable_dns_support = false
  tags = {
    Name = "my vpc"
  }
}

######## Subnets ########
          # GW #
resource "aws_internet_gateway" "ig" {
  vpc_id = var.vpc_id
  tags   = {
    Name = "internet_gateway"
  }
}

       # Elastic ip #
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.ig]
}

           # NAT #

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public_subnet.*.id, 0)
  depends_on    = [aws_internet_gateway.ig]
  tags = {
    Name        = "nat"
  }
}

        # Public subnet #
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.public_subnets_cidr)
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name        = "public-subnets"
  }
}

        # Private subnet #
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.private_subnets_cidr)
  cidr_block              = element(var.private_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false
  tags = {
    Name        = "private-subnets"
  }
}

#resource "aws_subnet" "my_subnet" {
#  vpc_id     = var.vpc_id
#  cidr_block = var.cidr_block
#  #  private_subnets = var.private_subnet
#  #  public_subnets  = var.public_subnet
#
#}

resource "aws_instance" "ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "instance ec2"
  }
}

