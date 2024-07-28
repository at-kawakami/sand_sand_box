resource "aws_subnet" "public-1a" {
  assign_ipv6_address_on_creation                = false
  availability_zone                              = "ap-northeast-1a"
  cidr_block                                     = "10.0.0.0/20"
  customer_owned_ipv4_pool                       = null
  enable_dns64                                   = false
  ipv6_cidr_block                                = null
  ipv6_native                                    = false
  outpost_arn                                    = null
  private_dns_hostname_type_on_launch            = "ip-name"
  tags = {
    Name = "${var.name}-public-1a"
  }
  tags_all = {
    Name = "${var.name}-public-1a"
  }
  vpc_id = "${var.vpc_id}"
}

resource "aws_subnet" "public-1c" {
  assign_ipv6_address_on_creation                = false
  availability_zone                              = "ap-northeast-1c"
  cidr_block                                     = "10.0.16.0/20"
  customer_owned_ipv4_pool                       = null
  enable_dns64                                   = false
  ipv6_cidr_block                                = null
  ipv6_native                                    = false
  outpost_arn                                    = null
  private_dns_hostname_type_on_launch            = "ip-name"
  tags = {
    Name = "${var.name}-public-1c"
  }
  tags_all = {
    Name = "${var.name}-public-1c"
  }
  vpc_id = "${var.vpc_id}"
}

resource "aws_subnet" "private-1a" {
  assign_ipv6_address_on_creation                = false
  availability_zone                              = "ap-northeast-1a"

  cidr_block                                     = "10.0.32.0/20"
  customer_owned_ipv4_pool                       = null
  enable_dns64                                   = false
  ipv6_cidr_block                                = null
  ipv6_native                                    = false
  outpost_arn                                    = null
  private_dns_hostname_type_on_launch            = "ip-name"
  tags = {
    Name = "${var.name}-private-1a"
  }
  tags_all = {
    Name = "${var.name}-private-1a"
  }
  vpc_id = "${var.vpc_id}"
}

resource "aws_subnet" "private-1c" {
  assign_ipv6_address_on_creation                = false
  availability_zone                              = "ap-northeast-1c"

  cidr_block                                     = "10.0.48.0/20"
  customer_owned_ipv4_pool                       = null
  enable_dns64                                   = false
  ipv6_cidr_block                                = null
  ipv6_native                                    = false
  outpost_arn                                    = null
  private_dns_hostname_type_on_launch            = "ip-name"
  tags = {
    Name = "${var.name}-private-1c"
  }
  tags_all = {
    Name = "${var.name}-private-1c"
  }
  vpc_id = "${var.vpc_id}"
}


