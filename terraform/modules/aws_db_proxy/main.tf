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
  vpc_subnet_ids         = ["subnet-0dcc5856", "subnet-e9f2c3c1", "subnet-fcfaa2b5"]
  auth {
    auth_scheme               = "SECRETS"
    client_password_auth_type = "MYSQL_NATIVE_PASSWORD"
    description               = null
    iam_auth                  = "DISABLED"
    secret_arn                = var.secret_arn
    username                  = null
  }
}