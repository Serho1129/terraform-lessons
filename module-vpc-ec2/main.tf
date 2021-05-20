provider "aws" {
  region = local.region
}

locals {
  region = "eu-central-1"
}

################################################################################
# VPC Module
################################################################################

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-task1"
  cidr = "10.0.0.0/16"

  azs             = ["${local.region}a", "${local.region}b"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.11.0/24"]


  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    Name = "public-vpc-task1"
  }

  tags = {
    Owner       = "serho"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "vpc-task1"
  }
}
output "vpc" {
  value = vpc.private_subnets
}


################################################################################
# EC2 Module
################################################################################

module "ec2_task1" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = "my-cluster-ec2-task1"
  instance_count = 2

  ami           = "ami-08f11f4114f566d1a"
  instance_type = "t2.micro"
  monitoring    = false
  subnet_id     = [vpc.private_subnets.id]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
