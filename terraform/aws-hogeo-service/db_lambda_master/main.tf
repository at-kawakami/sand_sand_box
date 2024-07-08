terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = "ap-northeast-1"
}

variable "access_key" {

}

variable "secret_key" {

}

variable "service_name" {
  default = "hogeo-terraform"
}

locals {
  rds_proxy_role_name = "rds_proxy_role_hogeo"
}

module "aws_iam_policy" {
  source = "../../modules/aws_iam_policy/rds_proxy_role"
  name = "hogeo-rds-proxy-policy"
}

module "aws_iam_role" {
  source = "../../modules/aws_iam_role/rds_proxy_role"
  name = "hogeo-rds-proxy-role"
  aws_iam_policy = module.aws_iam_policy.rdsproxy_role
}

module "aws_db_instance" {
  source = "../../modules/aws_db_instance"
  name = var.service_name
  kms_key_id = "arn:aws:kms:ap-northeast-1:571429965935:key/d990ccb3-c647-49dc-a7aa-33b774d19bbd"

}
module "aws_db_proxy" {
  source = "../../modules/aws_db_proxy"
  name = "hogeo-db-proxy"
  role_arn = module.aws_iam_role.rds_proxy_role_arn
  #Todo
  secret_arn = "arn:aws:secretsmanager:ap-northeast-1:571429965935:secret:rds-db-credentials/hogeodb/admin/1720075954820-6hhLSv"
}