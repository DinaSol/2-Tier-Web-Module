variable "vpc" {}
data "aws_vpc" "vpc" {
  id = var.vpc
}

# variable "create-subnet" {}
variable "web-ami" {default = "ami-06b6c7fea532f597e" }
variable "instance_type" {default = "t2.micro"}
variable "tag-name" {}
variable "web-sg-name" {
  default = "dina-security-group1"
}

# public subnet from subnets-module
variable "web-sub-id" {
    type = string
}