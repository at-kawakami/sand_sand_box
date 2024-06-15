terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

variable "region" {
  default = "ap-northeast-1"
}

variable "access_key" {

}

variable "secret_key" {

}

# AWS プロバイダの設定

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}


#resource "aws_instance" "app_server" {
#  ami           = "ami-830c94e3"
#  instance_type = "t2.micro"
#
#  tags = {
#    Name = "ExampleAppServerInstance"
#  }
#}

