terraform {
  required_version = ">= 0.12"
}



resource "aws_subnet" "my_subnet" {
  vpc_id          = var.vpc_id
  cidr_block      = var.cidr_block
  private_subnets = var.private_subnet
  public_subnets  = var.public_subnet

}

resource "aws_instance" "ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "instance ec2"
  }
}
