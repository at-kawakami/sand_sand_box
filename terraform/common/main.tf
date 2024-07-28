terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  backend "s3" {
    bucket = "TBA"
    key    = "common"
    region = "ap-northeast-1"
    profile = "terraform-user"
  }

  required_version = ">= 1.2.0"
}
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = var.region
}

variable "access_key" {

}

variable "secret_key" {

}

variable "service_name" {
  default = "hogeo-terraform"
}

variable "region" {
  default = "ap-northeast-1"
}

module "aws_vpc" {
  source = "../modules/aws_vpc"
  name = var.service_name
}

module "aws_subnet" {
  source = "../modules/aws_subnet"
  name = var.service_name
  vpc_id = module.aws_vpc.vpc_id
  # Todo
  #zone = var.zone
}

module "aws_nat_gateway" {
  source = "../modules/aws_nat_gateway"
  name = var.service_name
  eip_allocate_id = "eipalloc-0c5e2ab3d59541f88"
  public_subnet1 = module.aws_subnet.public_subnet_1a
}

module "aws_internet_gateway" {
  source = "../modules/aws_internet_gateway"
  name = var.service_name
  vpc_id = module.aws_vpc.vpc_id
}

module "aws_route_table" {
  source = "../modules/aws_route_table"
  name = var.service_name
  vpc_id = module.aws_vpc.vpc_id
  nat_id = module.aws_nat_gateway.aws_nat_gateway_id
  gateway_id = module.aws_internet_gateway.igw_id
}

