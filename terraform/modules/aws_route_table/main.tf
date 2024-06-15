resource "aws_route_table" "main" {
  propagating_vgws = []
  route            = []
  tags             = {}
  tags_all         = {}
  vpc_id           = "${var.vpc_id}"
}

resource "aws_route_table" "rtb-public" {
  propagating_vgws = []
  route = [{
    carrier_gateway_id         = ""
    cidr_block                 = "0.0.0.0/0"
    core_network_arn           = ""
    destination_prefix_list_id = ""
    egress_only_gateway_id     = ""
    gateway_id                 = "${var.gateway_id}"
    instance_id                = ""
    network_interface_id       = ""
    ipv6_cidr_block            = null
    local_gateway_id           = ""
    nat_gateway_id             = ""
    network_interface_id       = ""
    transit_gateway_id         = ""
    vpc_endpoint_id            = ""
    vpc_peering_connection_id  = ""
  }]
  tags = {
    Name = "${var.name}-rtb-public"
  }
  tags_all = {
    Name = "${var.name}-rtb-public"
  }
  vpc_id = "${var.vpc_id}"
}

resource "aws_route_table" "rtb-private1-ap-northeast-1a" {
  propagating_vgws = []
  route = [{
    carrier_gateway_id         = ""
    cidr_block                 = "0.0.0.0/0"
    core_network_arn           = ""
    destination_prefix_list_id = ""
    egress_only_gateway_id     = ""
    gateway_id                 = ""
    instance_id                = ""
    network_interface_id       = ""
    ipv6_cidr_block            = null
    local_gateway_id           = ""
    nat_gateway_id             = "${var.nat_id}"
    network_interface_id       = ""
    transit_gateway_id         = ""
    vpc_endpoint_id            = ""
    vpc_peering_connection_id  = ""
  }]
  tags = {
    Name = "${var.name}-rtb-private2-ap-northeast-1c"
  }
  tags_all = {
    Name = "${var.name}-rtb-private2-ap-northeast-1c"
  }
  vpc_id = "${var.vpc_id}"
}

resource "aws_route_table" "rtb-private2-ap-northeast-1c" {
  propagating_vgws = []
  route = [{
    carrier_gateway_id         = ""
    cidr_block                 = "0.0.0.0/0"
    core_network_arn           = ""
    destination_prefix_list_id = ""
    egress_only_gateway_id     = ""
    gateway_id                 = ""
    instance_id                = ""
    network_interface_id       = ""
    ipv6_cidr_block            = null
    local_gateway_id           = ""
    nat_gateway_id             = "${var.nat_id}"
    network_interface_id       = ""
    transit_gateway_id         = ""
    vpc_endpoint_id            = ""
    vpc_peering_connection_id  = ""
  }]
  tags = {
    Name = "${var.name}-rtb-private2-ap-northeast-1c"
  }
  tags_all = {
    Name = "${var.name}-rtb-private2-ap-northeast-1c"
  }
  vpc_id = "${var.vpc_id}"
}



