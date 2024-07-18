# to RDS
resource "aws_security_group" "rds_rdsproxy" {
  description = "to RDS"
  #egress      = []
  ingress = [{
    cidr_blocks = []
    description = ""
    from_port        = 3306
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol         = "tcp"
    security_groups  = [aws_security_group.rdsproxy_lambda.id]
    self             = false
    to_port          = 3306
  }]
  name                   = "rds-rdsproxy-${var.name}"
  name_prefix            = null
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = var.vpc
}

# to RDS Proxy
resource "aws_security_group" "rdsproxy_lambda" {
  description = "to RDS Proxy"
  egress      = []
  ingress = [{
    cidr_blocks = []
    description = ""
    from_port        = 3306
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol         = "tcp"
    security_groups  = [aws_security_group.lambda_using_rdsproxy.id]
    self             = false
    to_port          = 3306
  }]
  name                   = "rdsproxy-lambda-${var.name}"
  name_prefix            = null
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = var.vpc
}

# to Lambda
resource "aws_security_group" "lambda_using_rdsproxy" {
  description = "to Lambda"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  name                   = "lambda-using-rdsproxy-${var.name}"
  name_prefix            = null
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = var.vpc
}