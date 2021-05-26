
locals {
  region = "eu-central-1"
}

provider "aws" {
  region = local.region
}

resource "aws_vpc" "vpc-ec2" {
  cidr_block = "10.0.0.0/16"
}

module "vpc-ec2" {
  source          = "./modules"
  vpc_id          = aws_vpc.vpc-ec2.id
  cidr_block      = "10.0.0.0/16"
  public_subnets_cidr  = "10.0.11.0/24"
  private_subnets_cidr = "10.0.1.0/24"
  availability_zones   = local.region
  ami           = "ami-08f11f4114f566d1a"
  instance_type = "t2.micro"
}