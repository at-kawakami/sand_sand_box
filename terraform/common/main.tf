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