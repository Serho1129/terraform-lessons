variable "cidr_block" {
  default = []
  description = "CIDR blocks"
}

variable "private_subnets_cidr" {
  default = []
  description = "CIDR blocks private"
}

variable "public_subnets_cidr" {
  default = []
  description = "CIDR blocks public"
}

variable "availability_zones" {
  default = []
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
