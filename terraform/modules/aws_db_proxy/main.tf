resource "aws_db_proxy" "main" {
  debug_logging          = false
  engine_family          = "MYSQL"
  idle_client_timeout    = 1800
  name                   = var.name
  require_tls            = false
  role_arn               = var.role_arn
  tags                   = {}
  tags_all               = {}
  vpc_security_group_ids = ["sg-0e383393b5e37d880"]
  # vpc_subnet_ids: at least 2 subnets
  vpc_subnet_ids         = [for i in var.public_subnets : i]
  auth {
    auth_scheme               = "SECRETS"
    client_password_auth_type = "MYSQL_NATIVE_PASSWORD"
    description               = null
    iam_auth                  = "DISABLED"
    secret_arn                = var.master_user_secret[0].secret_arn
    username                  = null
  }
}