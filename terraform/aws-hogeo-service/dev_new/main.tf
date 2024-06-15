terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
  #todo
  #backend "s3" {
  #  bucket = "TBA"
  #  key = "Network"
  #  region = "ap-northeast-1"
  #}
}

variable "access_key" {

}

variable "secret_key" {

}

variable "service_name" {
  
}



provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = "ap-northeast-1"
}

module "aws_vpc" {
  source = "../../modules/aws_vpc"
  name = var.service_name
  
}

module "aws_subnet" {
  source = "../../modules/aws_subnet"
  name = var.service_name
  vpc_id = module.aws_vpc.vpc_id
  
}

module "aws_internet_gateway" {
  source = "../../modules/aws_internet_gateway"
  name = var.service_name
  vpc_id = module.aws_vpc.vpc_id
}

module "aws_route_table" {
  source = "../../modules/aws_route_table"
  name = var.service_name
  nat_id = module.na
  gateway_id = module.aws_internet_gateway_id
  vpc_id = module.aws_vpc_id
}

module "aws_nat_gateway" {
  source = "../../modules/aws_nat_gateway"
  eip_allocate_id = module.aws_eip.eip_allocate_id
  name = var.service_name
  public_subnet1 = module.aws_subnet.public_subnet1
}

module "aws_network_interface" {
  source = "../../modules/aws_network_interface"
  public_subnet1 = module.aws_subnet.public_subnet1
  nat_id = module.aws_nat_gateway.nat_id
}