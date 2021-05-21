variable "cidr_block" {
  type = string
  description = "CIDR blocks"
}

variable "private_subnets_cidr" {
  type = string
  description = "CIDR blocks private"
}

variable "public_subnets_cidr" {
  type = string
  description = "CIDR blocks public"
}

variable "availability_zones" {
  type = string
  description = "availability zones"
}

variable "vpc_id" {
  type = string
  description = "public_subnets"
}

variable "ami" {
  type = string
  description = "public_subnets"
}

variable "instance_type" {
  type = string
  description = "public_subnets"
}
